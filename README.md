# football_shop_mobile

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