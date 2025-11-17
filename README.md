# football_shop_mobile
Nama : Kalista Wiarta
NPM : 2406351491
Kelas : PBP F

Tugas 7: Elemen Dasar Flutter

1. Apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget?

Widget tree adalah struktur hierarki yang menggambarkan bagaimana semua elemen di Flutter tersusun di dalam aplikasi.
Setiap widget bisa memiliki satu atau beberapa widget lain di dalamnya, yang disebut sebagai child.
Sebaliknya, widget yang menaungi widget lain disebut parent.

Hubungan parent–child ini penting karena menentukan bagaimana tampilan dan perilaku widget diatur.
Misalnya, sebuah Column (parent) bisa berisi beberapa Text atau Button (child), dan semua widget child akan mengikuti tata letak serta aturan yang ditentukan oleh widget parent-nya.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

Berikut widget-widget yang saya gunakan dalam proyek Football Shop beserta fungsinya:

MaterialApp → Sebagai root aplikasi yang menyediakan tema dan struktur dasar aplikasi berbasis Material Design.

Scaffold → Memberikan struktur utama halaman (app bar, body, floating button, dsb).

AppBar → Menampilkan judul aplikasi di bagian atas halaman.

SingleChildScrollView → Membuat halaman bisa di-scroll ketika kontennya terlalu panjang.

Padding → Memberi jarak di sekitar elemen agar tampilan lebih rapi.

Column dan Row → Menyusun widget secara vertikal dan horizontal.

Card → Membuat tampilan berbentuk kartu, digunakan untuk InfoCard.

Wrap → Menyusun tombol secara otomatis dalam baris dan kolom sesuai lebar layar.

Text → Menampilkan teks pada layar.

Icon → Menampilkan ikon pada tombol atau bagian lain.

InkWell → Memberikan efek interaksi (ripple effect) ketika pengguna menekan tombol.

SnackBar → Menampilkan pesan singkat di bagian bawah layar saat tombol ditekan.

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.

MaterialApp berfungsi sebagai entry point atau pembungkus utama dari aplikasi Flutter berbasis Material Design.
Widget ini menyediakan konfigurasi penting seperti tema warna (ThemeData), judul aplikasi, navigasi antar halaman, dan pengaturan tampilan dasar.

Widget ini sering digunakan sebagai widget root karena menjadi fondasi yang memastikan tampilan aplikasi konsisten dengan gaya desain Material dari Google, sehingga komponen seperti tombol, AppBar, dan Card bisa berfungsi dengan baik.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?

StatelessWidget adalah widget yang tidak memiliki keadaan (state) yang bisa berubah setelah dibuat.
Contohnya adalah widget teks atau ikon yang isinya tetap selama aplikasi berjalan.

StatefulWidget adalah widget yang memiliki state, sehingga tampilannya bisa berubah sesuai interaksi pengguna atau data baru.

Saya akan memilih StatelessWidget jika tampilan tidak perlu berubah (seperti halaman info pengguna),
dan memilih StatefulWidget jika butuh perubahan tampilan secara dinamis (misalnya form input atau counter).

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

BuildContext adalah objek yang menyimpan informasi tentang posisi sebuah widget di dalam widget tree.
Context ini penting karena digunakan untuk mengakses data dari widget lain yang berada di atasnya dalam tree, seperti tema, ukuran layar, atau Scaffold.

Dalam metode build(), BuildContext sering digunakan untuk menampilkan elemen UI atau memanggil fungsi seperti:

ScaffoldMessenger.of(context).showSnackBar(...)


yang membutuhkan context untuk mengetahui di halaman mana snackbar tersebut akan muncul.

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".

Hot reload memungkinkan kita melihat hasil perubahan kode hampir secara instan tanpa kehilangan state aplikasi.
Misalnya, ketika saya mengubah warna tombol atau teks, tampilan akan langsung diperbarui tanpa memulai ulang aplikasi dari awal.

Sementara itu, hot restart akan memulai ulang seluruh aplikasi dari awal dan menghapus semua state yang ada.
Biasanya digunakan jika ada perubahan besar seperti menambah variabel global atau mengubah struktur widget utama.

Tugas 8: Flutter Navigation, Layouts, Forms, and Input Elements

1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?

Navigator.push() digunakan untuk menambahkan halaman baru di atas halaman yang sedang dibuka, sehingga pengguna masih bisa kembali ke halaman sebelumnya dengan tombol “Back”.

Sementara Navigator.pushReplacement() digunakan untuk mengganti halaman saat ini dengan halaman baru, sehingga halaman sebelumnya dihapus dari stack dan tidak bisa dikembalikan.

Dalam aplikasi Football Shop:

Navigator.push() digunakan saat pengguna menekan tombol Tambah Produk pada halaman utama, agar setelah menyimpan produk mereka bisa kembali ke halaman utama.

Navigator.pushReplacement() digunakan pada Drawer untuk berpindah antar halaman utama tanpa menumpuk halaman lama di memori.

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

Saya menggunakan hierarchy widget agar seluruh halaman memiliki struktur dan gaya tampilan yang konsisten:

Scaffold menjadi kerangka utama setiap halaman yang menampung elemen penting seperti AppBar, Drawer, dan body.

AppBar menampilkan judul Football Shop di bagian atas, dengan warna biru khas toko.

Drawer berfungsi sebagai navigasi global antar halaman seperti Home dan Add Product.

Dengan struktur ini, navigasi terasa natural, tampilan rapi, dan setiap halaman memiliki identitas visual yang sama.

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

Widget-widget ini membantu menjaga tampilan form agar tetap responsif dan nyaman dilihat:

Padding memberi jarak antar elemen supaya tidak terlalu menempel di tepi layar.

SingleChildScrollView memungkinkan seluruh isi form di-scroll saat layar tidak cukup tinggi.

Column (dan kadang ListView) digunakan untuk menyusun elemen-elemen form secara vertikal dengan rapi.

Contohnya, pada halaman Add Product Form, semua input (TextFormField, Dropdown, SwitchListTile) dibungkus dengan SingleChildScrollView dan diberi Padding agar tetap bisa diakses pada layar kecil dan tampak teratur.

4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

Saya menetapkan warna utama aplikasi menggunakan ColorScheme pada MaterialApp dengan kode warna biru #1976D2, yang digunakan secara konsisten di seluruh aplikasi.

Warna ini diterapkan pada:

AppBar di semua halaman,

DrawerHeader,

tombol utama seperti Save Product, dan

elemen aktif seperti SwitchListTile.

Dengan konsistensi warna ini, aplikasi terlihat profesional dan sesuai dengan identitas visual brand Football Shop yang sporty dan modern.

5. Bagaimana validasi input diimplementasikan agar sesuai dengan ketentuan tugas?

Setiap elemen input pada form memiliki validasi yang menyesuaikan tipe datanya:

Name, Category, dan Brand: wajib diisi, minimal 2–3 karakter, maksimal sesuai batas CharField di Django (100–255).

Price dan Stock: wajib diisi, harus berupa angka positif (tidak boleh negatif atau nol).

Description: wajib diisi, minimal 10 karakter agar informatif.

Thumbnail (URL): opsional, tetapi jika diisi harus dalam format URL valid.

isFeatured dan bestSeller: menggunakan SwitchListTile sebagai input boolean.

Selain itu, tombol Save Product hanya dapat ditekan jika semua validasi terpenuhi, dan hasil input akan ditampilkan kembali pada pop-up (AlertDialog) setelah disimpan.


Tugas 9: Integrasi Layanan Web Django dengan Aplikasi Flutter

1. Alasan perlunya model Dart untuk pengolahan data JSON

Model Dart digunakan untuk memastikan data yang diterima dan dikirim memiliki struktur serta tipe yang konsisten. Keuntungan penggunaan model:

setiap field memiliki tipe data yang jelas,

null-safety dapat dijaga,

proses parsing JSON jauh lebih aman,

kode lebih mudah dirawat,

perubahan struktur data cukup dilakukan di satu tempat (fromJson / toJson).

Jika hanya menggunakan Map<String, dynamic>:

potensi error runtime lebih tinggi,

pengecekan tipe harus dilakukan manual,

data rentan null,

struktur menjadi tidak terkontrol,

maintainability menurun.

Model Dart memberikan jaminan integritas data pada seluruh aplikasi.

2. Fungsi package http dan CookieRequest dalam tugas ini

Pada proyek Flutter yang terintegrasi dengan Django, terdapat dua mekanisme utama untuk melakukan komunikasi jaringan, yaitu menggunakan package http dan menggunakan CookieRequest. Keduanya sama-sama dapat mengirim permintaan HTTP, tetapi memiliki fungsi dan peran yang berbeda.

Fungsi package http

Package http merupakan alat dasar untuk melakukan permintaan GET atau POST tanpa menyertakan informasi autentikasi apa pun. Setiap request yang dikirim tidak menyimpan session, cookie, maupun kredensial. Karena sifatnya stateless, http hanya cocok digunakan untuk:

mengakses endpoint publik,

mengambil data yang tidak bergantung pada status login,

melakukan request yang tidak membutuhkan cookie Django.

Package ini tepat digunakan ketika server tidak memerlukan identitas pengguna untuk memberikan respons.

Fungsi CookieRequest

Berbeda dengan http, objek CookieRequest dirancang agar dapat menyimpan cookie autentikasi Django. Ketika pengguna melakukan login melalui endpoint Django, CookieRequest menyimpan session ID dan otomatis melampirkannya pada setiap request berikutnya. Dengan begitu, server dapat mengenali pengguna yang sedang login.

CookieRequest digunakan untuk:

proses login dan logout ke Django,

mengirim request ke endpoint yang membutuhkan autentikasi,

mengakses data milik pengguna yang login,

operasi CRUD yang hanya diizinkan untuk user tertentu.

Perbedaan peran keduanya

Package http hanya memberikan kemampuan dasar untuk melakukan request tanpa konteks pengguna. CookieRequest menyediakan mekanisme yang lebih lengkap untuk menjaga sesi autentikasi, mengelola cookie, dan mengakses endpoint Django yang membutuhkan identitas pengguna.

Dengan demikian, http ideal untuk endpoint publik, sedangkan CookieRequest menjadi komponen penting untuk seluruh fitur yang berhubungan dengan autentikasi Django.

3. Alasan instance CookieRequest dibagikan ke seluruh bagian aplikasi

Status login disimpan di dalam CookieRequest. Jika setiap halaman memiliki instance berbeda:

status login tidak terbawa,

Django akan menganggap request berasal dari pengguna anonim,

endpoint seperti /json/user-products/ akan mengembalikan Unauthorized.

Dengan memberikan CookieRequest melalui Provider, satu instance dapat digunakan oleh seluruh widget sehingga status autentikasi tetap konsisten selama aplikasi berjalan.

4. Konfigurasi konektivitas Flutter ↔ Django

Agar komunikasi berhasil, konfigurasi berikut dibutuhkan:

a. 10.0.2.2 pada ALLOWED_HOSTS

Android emulator tidak dapat mengakses localhost langsung.
10.0.2.2 digunakan sebagai jembatan ke localhost komputer.
Tanpa ini, Django akan menolak request dengan error 400 Bad Request.

b. CORS diaktifkan

Request lintas origin dari aplikasi Flutter akan diblokir jika CORS tidak diizinkan.
Aktivasi CORS membuat Flutter dapat mengambil data dari domain Django.

c. Pengaturan cookie dan SameSite

Autentikasi Django bergantung pada cookie session.
Jika pengaturan SameSite, CSRF, atau cookie tidak benar, cookie tidak terkirim sehingga login tidak dikenali oleh Django.

d. Izin Internet pada Android

Tanpa:

<uses-permission android:name="android.permission.INTERNET" />


semua request dari Flutter akan gagal dan tidak ada komunikasi dengan Django.

5. Mekanisme pengiriman data: dari input hingga ditampilkan di Flutter

Pengguna mengisi form pada Flutter.

Flutter mengirim data melalui request.postJson(...) ke Django.

Django menerima data JSON, memvalidasi, dan menyimpan ke database.

Flutter mengambil ulang data melalui endpoint JSON (/json/ atau /json/user-products/).

Data diubah menjadi objek Dart (ProductEntry).

UI menampilkan data tersebut dalam card/grid/detail page.

Alurnya memastikan data mengalir dengan konsisten dan aman antara Flutter ↔ Django.

6. Mekanisme autentikasi dari login, register, hingga logout
a. Register

Flutter mengirim POST ke /ajax/register/,

Django menvalidasi data UserCreationForm,

akun disimpan dan dikembalikan respons success.

b. Login

Flutter mengirim username & password ke /ajax/login/,

Django mengecek kredensial dengan authenticate,

jika valid → server membuat session dan mengirim cookie,

CookieRequest menyimpan session cookie sehingga halaman lain dapat mengakses endpoint login-required.

c. Logout

Flutter memanggil request.logout(),

Django menghapus session,

CookieRequest menghapus cookie dari aplikasi Flutter.

Setelah login berhasil, halaman utama (menu) ditampilkan melalui Navigator.pushReplacement.

7. Implementasi setiap checklist (step-by-step)
1. Deployment Django

menjalankan proyek,

memastikan endpoint JSON muncul,

memastikan /json/, /json/user-products/, dan /ajax/login/ bekerja.

2. Fitur registrasi Flutter

membuat halaman Register,

mengirim POST ke /ajax/register/,

menangani error dan snackbar sukses.

3. Halaman login Flutter

membuat UI login,

mengirim POST melalui CookieRequest ke /ajax/login/,

menyimpan session cookie.

4. Integrasi autentikasi

memastikan seluruh request menggunakan CookieRequest,

memblok pengguna tidak terautentikasi,

mengaktifkan session pada Django.

5. Model Dart

membuat ProductEntry sesuai field Django,

menyesuaikan tipe data (price, stock, id).

6. Halaman daftar item

mengambil data dari endpoint JSON,

menampilkan name, price, description, thumbnail, category, is_featured.

7. Halaman detail item

menampilkan seluruh atribut ProductEntry,

menyediakan tombol kembali ke daftar produk.

8. Filtering item berdasarkan user

menambahkan filter (all / my products),

memanggil /json/user-products/ untuk item milik user login.

Semua bagian ini membentuk satu alur utuh integrasi Django–Flutter yang sesuai dengan checklist penilaian.