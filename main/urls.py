from django.urls import path
from main.views import (
    # Main Page & CRUD
    show_main,
    create_product,
    show_product,
    edit_product,
    delete_product,

    # Serializer (JSON & XML)
    show_xml,
    show_json,
    show_xml_by_id,
    show_json_by_id,

    # Auth classic
    register,
    login_user,
    logout_user,

    # AJAX CRUD
    add_product_entry_ajax,
    edit_product_entry_ajax,
    delete_product_ajax,

    # AJAX Auth
    ajax_login,
    ajax_register,
)

app_name = "main"

urlpatterns = [
    # ========================
    # MAIN PAGE
    # ========================
    path("", show_main, name="show_main"),

    # ========================
    # LEGACY CRUD (Server-rendered)
    # ========================
    path("create-product/", create_product, name="create_product"),
    path("product/<str:id>/", show_product, name="show_product"),
    path("product/<int:id>/edit/", edit_product, name="edit_product"),
    path("product/<int:id>/delete/", delete_product, name="delete_product"),

    # ========================
    # SERIALIZER ENDPOINTS
    # ========================
    path("xml/", show_xml, name="show_xml"),
    path("json/", show_json, name="show_json"),
    path("xml/<str:product_id>/", show_xml_by_id, name="show_xml_by_id"),
    path("json/<str:product_id>/", show_json_by_id, name="show_json_by_id"),

    # ========================
    # AUTH CLASSIC
    # ========================
    path("register/", register, name="register"),
    path("login/", login_user, name="login"),
    path("logout/", logout_user, name="logout"),

    # ========================
    # AJAX CRUD
    # ========================
    path("add-product-entry/", add_product_entry_ajax, name="add_product_entry_ajax"),
    path("edit-product/<str:id>/", edit_product_entry_ajax, name="edit_product_entry_ajax"),
    path("delete-product/<str:id>/", delete_product_ajax, name="delete_product_ajax"),

    # ========================
    # AJAX AUTH
    # ========================
    path("ajax/login/", ajax_login, name="ajax_login"),
    path("ajax/register/", ajax_register, name="ajax_register"),
]
