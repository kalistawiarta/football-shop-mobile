from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
from django.core import serializers
from django.shortcuts import render, redirect, get_object_or_404
from main.forms import ProductForm
from main.models import Product
from django.contrib import messages
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth import login, logout, authenticate
from django.contrib.auth.decorators import login_required
from django.urls import reverse
from django.utils import timezone
import datetime

# AJAX & Security
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST
from django.utils.html import strip_tags


# ========================
# MAIN PAGE VIEW
# ========================
@login_required(login_url='/login')
def show_main(request):
    filter_type = request.GET.get("filter", "all")

    if filter_type == "my":
        product_list = Product.objects.filter(user=request.user)
    elif filter_type == "best":
        product_list = Product.objects.filter(best_seller=True)
    elif filter_type == "new":
        week_ago = timezone.now() - datetime.timedelta(days=7)
        product_list = Product.objects.filter(created_at__gte=week_ago)
    else:
        product_list = Product.objects.all()

    context = {
        "product_list": product_list,
        "total_products": Product.objects.count(),
        "total_best": Product.objects.filter(best_seller=True).count(),
        "total_new": Product.objects.filter(
            created_at__gte=timezone.now() - datetime.timedelta(days=7)
        ).count(),
        "last_login": request.COOKIES.get("last_login", "Never"),
    }
    return render(request, "home.html", context)


# ========================
# LEGACY CRUD (server-rendered)
# ========================
@login_required(login_url='/login')
def create_product(request):
    form = ProductForm(request.POST or None)
    if form.is_valid() and request.method == "POST":
        product_entry = form.save(commit=False)
        product_entry.user = request.user
        product_entry.save()
        messages.success(request, "Produk berhasil ditambahkan.")
        return redirect("main:show_main")
    return render(request, "create_product.html", {"form": form})


@login_required(login_url='/login')
def edit_product(request, id):
    product = get_object_or_404(Product, pk=id, user=request.user)
    form = ProductForm(request.POST or None, instance=product)
    if form.is_valid() and request.method == "POST":
        form.save()
        messages.success(request, "Produk berhasil diperbarui.")
        return redirect("main:show_main")
    return render(request, "edit_product.html", {"form": form})


@login_required(login_url='/login')
def delete_product(request, id):
    product = get_object_or_404(Product, pk=id, user=request.user)
    if request.method == "POST":
        product.delete()
        messages.success(request, "Produk berhasil dihapus.")
    else:
        messages.error(request, "Metode tidak diizinkan.")
    return redirect("main:show_main")


@login_required(login_url='/login')
def show_product(request, id):
    product = get_object_or_404(Product, pk=id)
    return render(request, "product_detail.html", {"product": product})


# ========================
# SERIALIZER VIEWS
# ========================
def show_xml(request):
    data = serializers.serialize("xml", Product.objects.all())
    return HttpResponse(data, content_type="application/xml")


def show_xml_by_id(request, product_id):
    data = serializers.serialize("xml", Product.objects.filter(pk=product_id))
    return HttpResponse(data, content_type="application/xml")


def show_json(request):
    data = [
        {
            "id": str(p.id),
            "name": p.name,
            "description": p.description,
            "price": float(p.price),
            "stock": p.stock,
            "category": p.category,
            "thumbnail": p.thumbnail,
            "best_seller": p.best_seller,
            "user_id": p.user.id if p.user else None,
        }
        for p in Product.objects.all()
    ]
    return JsonResponse(data, safe=False)


def show_json_by_id(request, product_id):
    try:
        p = Product.objects.select_related("user").get(pk=product_id)
        data = {
            "id": str(p.id),
            "name": p.name,
            "description": p.description,
            "price": float(p.price),
            "stock": p.stock,
            "category": p.category,
            "thumbnail": p.thumbnail,
            "best_seller": p.best_seller,
            "user_id": p.user.id if p.user else None,
            "user_username": p.user.username if p.user else None,
        }
        return JsonResponse(data)
    except Product.DoesNotExist:
        return JsonResponse({"error": "Not found"}, status=404)


# ========================
# AJAX: CREATE PRODUCT
# ========================
@csrf_exempt
@require_POST
def add_product_entry_ajax(request):
    name = strip_tags(request.POST.get("name") or "")
    description = strip_tags(request.POST.get("description") or "")
    price = request.POST.get("price") or 0
    stock = request.POST.get("stock") or 0
    category = request.POST.get("category") or ""
    thumbnail = request.POST.get("thumbnail") or None
    best_seller = bool(request.POST.get("best_seller"))
    user = request.user if request.user.is_authenticated else None

    Product.objects.create(
        name=name,
        description=description,
        price=price,
        stock=stock,
        category=category,
        thumbnail=thumbnail,
        best_seller=best_seller,
        user=user,
    )
    return HttpResponse(b"CREATED", status=201)


# ========================
# AJAX: EDIT PRODUCT
# ========================
@csrf_exempt
@require_POST
def edit_product_entry_ajax(request, id):
    try:
        product = Product.objects.get(pk=id)

        if not (request.user.is_authenticated and product.user == request.user):
            return JsonResponse({"error": "Unauthorized"}, status=403)

        product.name = strip_tags(request.POST.get("name") or product.name)
        product.description = strip_tags(request.POST.get("description") or product.description)
        if request.POST.get("price") is not None:
            product.price = request.POST.get("price")
        if request.POST.get("stock") is not None:
            product.stock = request.POST.get("stock")
        if request.POST.get("category"):
            product.category = request.POST.get("category")
        if "thumbnail" in request.POST:
            product.thumbnail = request.POST.get("thumbnail") or None
        product.best_seller = bool(request.POST.get("best_seller"))

        product.save()
        return HttpResponse(b"UPDATED", status=200)

    except Product.DoesNotExist:
        return JsonResponse({"error": "Not found"}, status=404)


# ========================
# AJAX: DELETE PRODUCT
# ========================
@csrf_exempt
@require_POST
def delete_product_ajax(request, id):
    try:
        product = Product.objects.get(pk=id, user=request.user)
        product.delete()
        return HttpResponse(b"DELETED", status=200)
    except Product.DoesNotExist:
        return HttpResponse(b"NOT FOUND", status=404)


# ========================
# AUTHENTICATION (Regular)
# ========================
def register(request):
    form = UserCreationForm()
    if request.method == "POST":
        form = UserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Akun berhasil dibuat. Silakan login.")
            return redirect("main:login")
    return render(request, "register.html", {"form": form})


def login_user(request):
    if request.method == "POST":
        form = AuthenticationForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            response = HttpResponseRedirect(reverse("main:show_main"))
            response.set_cookie("last_login", str(datetime.datetime.now()))
            return response
    else:
        form = AuthenticationForm(request)
    return render(request, "login.html", {"form": form})


def logout_user(request):
    logout(request)
    response = HttpResponseRedirect(reverse("main:login"))
    response.delete_cookie("last_login")
    return response


# ========================
# AUTHENTICATION (AJAX)
# ========================
@csrf_exempt
@require_POST
def ajax_login(request):
    username = request.POST.get("username")
    password = request.POST.get("password")
    user = authenticate(username=username, password=password)

    if user:
        login(request, user)
        return JsonResponse({"status": "success"})
    return JsonResponse(
        {"status": "error", "message": "Invalid credentials"}, status=400
    )


@csrf_exempt
@require_POST
def ajax_register(request):
    form = UserCreationForm(request.POST)
    if form.is_valid():
        form.save()
        return JsonResponse({"status": "success"})
    return JsonResponse({"status": "error", "errors": form.errors}, status=400)
