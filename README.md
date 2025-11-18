# TUGAS 7

1.  Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child bekerja antar widget.
Sepemahaman saya, widget tree itu ibarat silsilah keluarga untuk semua widget yang menyusun tampilan aplikasi kita. Di Flutter, semuanya adalah widget. Untuk membuat tampilan yang kompleks, kita "membungkus" widget di dalam widget lain. Susunan bungkusan inilah yang disebut tree (pohon).

Hubungan Parent-Child (Induk-Anak):
Widget yang membungkus widget lain disebut parent.
Widget yang dibungkus di dalamnya disebut child.

Contohnya di proyek kita, di file menu.dart, kita punya Scaffold. Di dalam body milik Scaffold, kita punya Padding. Di dalam Padding, kita punya Column. Di dalam Column, kita punya Row dan GridView.
Jadi, silsilahnya seperti ini: Scaffold (Parent dari) -> Padding (Parent dari) -> Column (Parent dari) -> Row dan GridView (keduanya adalah child dari Column).

Hubungan ini sangat penting karena parent bisa mengontrol bagaimana child-nya ditampilkan (misalnya ukuran dan posisi), dan child bisa mendapatkan data (seperti tema warna) dari parent.

2. Widget yang digunakan dalam proyek ini dan fungsinya,

Disini, saya menggunakan beberapa widget utama:

- MaterialApp: Ini adalah bagian utama aplikasi saya yang menyediakan fungsionalitas dasar Material Design, seperti tema dan navigasi.
- MyApp: Ini widget kustom kita sendiri, yang fungsinya adalah mengembalikan MaterialApp.
- MyHomePage: Ini juga widget kustom saya yang berisi seluruh tampilan halaman utama.
- Scaffold: Ini adalah kerangka halaman. Dia yang menyediakan tempat untuk AppBar (di atas) dan body (konten utama).
- AppBar: Judul di bagian paling atas aplikasi, tempat kita meletakkan judul "SP Sportswear".
- Padding: Fungsinya memberi jarak (spasi) di sekeliling child-nya (dalam kasus ini, Column).
- Column: Menyusun anak-anaknya (yaitu Row dan Center) secara vertikal (dari atas ke bawah).
- Row: Menyusun anak-anaknya (yaitu tiga InfoCard) secara horizontal (dari kiri ke kanan).
- InfoCard: Ini widget kustom yang dibuat untuk menampilkan kotak info (NPM, Nama, Kelas).
- SizedBox: Kita gunakan ini untuk memberi jarak vertikal (spasi) antara Row (info) dan Center (menu).
- Center: Membuat child-nya (yaitu Column yang berisi teks dan grid) berada di tengah.
- GridView: Menampilkan anak-anaknya (yaitu ItemCard) dalam format grid. Di sini saya atur 3 kolom (crossAxisCount: 3).
- ItemCard: Widget kustom untuk sebuah tombol menu (seperti "Create Products").
- Material: Kita gunakan di dalam ItemCard untuk memberi warna latar belakang (merah, biru, hijau) dan sudut melengkung.
- InkWell: Ini yang membuat ItemCard bisa diklik (onTap) dan memunculkan efek "cipratan air" (splash effect).
- ScaffoldMessenger & SnackBar: Ini kita panggil di dalam onTap untuk memunculkan notifikasi pesan kecil di bagian bawah layar.
- Text: Tentu saja, untuk menampilkan semua teks (judul, nama, NPM, nama tombol, dll).
- Icon: Untuk menampilkan ikon di dalam ItemCard.

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
MaterialApp adalah widget yang membungkus seluruh aplikasi kita. Fungsi utamanya adalah menyediakan "pondasi" dan fungsionalitas standar yang dibutuhkan aplikasi Material Design. 
Ini termasuk,
Tema (Theme): Dia yang memegang data skema warna (colorScheme) aplikasi kita. Itulah mengapa AppBar dan ItemCard kita bisa tahu warna primernya (Theme.of(context).colorScheme.primary).
Navigasi (Routing): Dia yang mengelola tumpukan halaman, sehingga kita bisa pindah dari satu halaman ke halaman lain (meskipun di proyek ini kita baru punya satu halaman).
Lokalilasi (Bahasa): Mengatur bahasa dan teks standar untuk aplikasi.

Dia sering digunakan sebagai widget root (akar) karena widget-widget lain di seluruh aplikasi perlu "mengambil" atau "mewarisi" data penting darinya (seperti data tema dan navigasi). Tanpa MaterialApp di akarnya, Scaffold dan widget Material Design lainnya tidak akan berfungsi dengan benar.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?

Perbedaan utamanya ada pada data (State).
StatelessWidget (Widget 'Statis')
- Tampilannya tetap dan tidak bisa berubah setelah widget-nya dibuat.
- Datanya bersifat immutable (tidak bisa diubah). Data konfigurasinya (seperti nama dan NPM di InfoCard kita) diterima dari parent-nya dan harus di-set sebagai final.
- Metode build-nya biasanya hanya dipanggil sekali.
- Contoh di proyek saya: MyApp, MyHomePage, InfoCard, dan ItemCard semuanya adalah StatelessWidget karena tampilannya (teks, ikon, warna) diatur sekali saja saat dibuat.

StatefulWidget (Widget 'Dinamis')
- Tampilannya bisa berubah-ubah berkali-kali selama aplikasi berjalan.
- Dia punya objek State internal, tempat menyimpan data yang bisa berubah (misalnya, angka counter, teks di form, atau status checkbox).
- Ketika data di dalam State-nya berubah (dengan memanggil fungsi setState()), Flutter akan otomatis memanggil metode build lagi untuk "menggambar ulang" widget-nya dengan data yang baru.

Pilih StatelessWidget (ini pilihan default) jika tampilan widget tidak perlu berubah berdasarkan interaksi pengguna atau data internal. Seperti InfoCard yang hanya menampilkan data.

Pilih StatefulWidget jika ingin widget tersebut berubah secara internal. Misalnya, jika kita ingin membuat form input teks, checkbox yang bisa dicentang, atau halaman yang mengambil data dari internet lalu menampilkannya.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
BuildContext merupakan alamat untuk sebuah widget di dalam widget tree. Dia memberi tahu widget tersebut di mana lokasinya persis di dalam struktur pohon.
Setiap widget punya BuildContextnya sendiri. Ini sangat penting karena widget sering perlu berinteraksi dengan parentnya. Penggunaan di metode build: Setiap metode build harus menerima parameter BuildContext context. context inilah yang menjadi "alamat" dari widget yang sedang kita bangun. Contoh pada kode yang saya buat: Theme.of(context).colorScheme.primary dan ScaffoldMessenger.of(context).showSnackBar(...). 

6.  Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
Hot Reload -> Ini menyuntikkan file kode Dart yang baru diubah ke dalam Dart Virtual Machine (VM) yang sedang berjalan. Dengan ini, aplikasi langsung diperbarui dengan tampilan baru tanpa kehilangan State. Contohnya, Kita sedang mengubah warna tombol ItemCard dari Colors.blue menjadi Colors.green. Kita tekan Hot Reload, dan dalam 1-2 detik, warna tombol di aplikasi (di HP atau emulator) langsung berubah, tanpa aplikasinya restart dari awal. Ini sangat cepat untuk debugging UI.
Hot Restart -> Ini mematikan Dart VM yang sedang berjalan dan me-restart aplikasi dari awal. Dengan ini, aplikasi akan dimuat ulang dari awal. Semua State (data sementara, misal isi form atau angka counter) akan hilang dan kembali ke nilai awalnya. Ini lebih lambat dari Hot Reload, tapi jauh lebih cepat daripada stop dan run ulang. Biasanya ini diperlukan jika kita mengubah sesuatu yang besar yang tidak bisa ditangani Hot Reload (misalnya, mengubah constructor atau data global). 

# TUGAS 8

1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
Perbedaan Navigator.push() dan Navigator.pushReplacement(), 
Secara sederhana, perbedaannya ada pada "jejak" navigasi. Navigator push ini bekerja dengan menumpuk layer baru di atas suatu tumpukan. Dan halaman kita sebelumnya masih ada dibawahnya. 
Hal yang akan terjadi adalah user bisa menekan tombol kembali, untuk kembali ke halaman sebelumnya. Disini digunakan pada football shop saat ingin kembali ke halaman sebelumnya. Dan misal, ketika user menekan tombol "Create Products" di halaman utama, untuk membuka ProductFormPage. Setelah mengisi form, pengguna bisa kembali ke menu utama. 
Navigator.pushReplacement(), bekerja dengan membuang halaman sebelumnya dari stack/tumpukannya, jadi seperti mengganti halaman dengan halaman baru. Membuka halam baru, lalu menghapus halaman saat ini(user tidak bisa kembali ke halaman sebelumnya). Disini saya menggunakannya pada LeftDrawer() saat menekan "Home". Tujuannya untuk membersihkan stack" navigation tersebut. Misalnya, kita ada di halaman Create Products Form, kita bisa menggunakan navbar(left drawer) dan menekan home untuk kembali ke halaman utama.

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
Scaffold: Ini merupakan kerangka dari setiap halaman. Hampir setiap halaman di aplikasi saya(seperti MyHomePage dan ProductFormPage) menggunakan Scaffold sebagai widget paling atas. Scaffold inilah yang menyediakan slot standar untuk AppBar (di atas), body (di tengah), dan Drawer (di samping).
AppBar: Ini adalah header di bagian atas halaman. Dengan menempatkan AppBar di dalam setiap Scaffold, memastikan bahwa setiap halaman memiliki title bar di lokasi yang sama. Meskipun judulnya bisa berbeda, tampilannya tetap konsisten.
Drawer: Ini adalah menu sidebar. Bagian terbaiknya adalah kita hanya perlu membuatnya satu kali (di file lib/widgets/left_drawer.dart). Kemudian, di setiap halaman (MyHomePage atau ProductFormPage), Kita hanya perlu memanggilnya dengan properti drawer: const LeftDrawer(). Ini adalah cara paling efisien untuk memastikan menu navigasi utama 100% identik di seluruh aplikasi.

Kombinasi ketiganya memberi pengguna pengalaman yang terbilang nyaman di setiap kali mengakses app karena mereka selalu tahu di mana menemukan judul, di mana menemukan menu, dan di mana konten utama berada.

3.  Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
Widget layout ini sangat penting untuk membuat form kita berfungsi dan nyaman digunakan. Contoh:
Padding, tanpa Padding, input field akan menempel rapat satu sama lain dan juga menempel ke tepi layar. Ini membuat form terlihat sempit dan sulit dibaca.
Contohnya di ProductFormPage, setiap TextFormField dan DropdownButtonFormField dibungkus di dalam Padding(padding: const EdgeInsets.all(8.0), ........etc). Ini memberikan jarak 8 pixel di sekeliling setiap field, membuat tampilannya jauh lebih rapi dan terorganisir.

SingleChildScrollView, Ini adalah penyelamat untuk form. Saat pengguna mengetik di TextFormField, keyboard akan muncul dari bawah. Jika form kita panjang, keyboard itu bisa menutupi field di bagian bawah (seperti tombol "Save"). SingleChildScrollView membungkus form dan secara otomatis mengizinkan pengguna untuk scroll ke bawah, memastikan semua field tetap bisa diakses.
Contohnya di ProductFormPage, seluruh Form saya(yang berisi Column dan semua input field-nya) dibungkus di dalam SingleChildScrollView.

ListView, mirip dengan SingleChildScrollView, ListView menyediakan kemampuan scroll secara otomatis. ListView sangat cocok untuk menampilkan daftar item yang jumlahnya tidak pasti.
Contohnya, di LeftDrawer. Drawer saya berisi ListView yang menampung DrawerHeader dan ListTile (tombol menu). Jika suatu hari nanti saya ingin menambahkan banyak tombol menu, ListView akan memastikan menu tersebut bisa di-scroll.

4.  Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
Disini kita bisa mengatur identitas visual (brand) aplikasi di file lib/main.dart. Di dalam widget MaterialApp, Anda akan menemukan properti theme: ThemeData(...). Di sinilah pusatnya dari seluruh styling aplikasinya. Disini saya ada contoh,
theme: ThemeData(
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
      .copyWith(secondary: Colors.blueAccent[400]),
),
Ini memberi tahu Flutter bahwa warna utama aplikasinya adalah Colors.blue. Flutter kemudian secara otomatis menggunakan warna ini (dan berbagai variasinya yang lebih gelap/terang) untuk mewarnai komponen utama seperti AppBar. Dengan mengaturnya di satu tempat ini, saya tidak perlu lagi mengatur warna AppBar secara manual di setiap halaman. Jika suatu hari nanti misal Football Shop  berganti brand menjadi warna hijau, kita hanya perlu mengubah Colors.blue menjadi Colors.green di file main.dart, dan seluruh AppBar di aplikasinya akan otomatis ikut berubah. Jadi akan tetap konsisten dengan brand tokonya.

# TUGAS 9



1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?

Saat kita berinteraksi dengan backend seperti Django, data yang dipertukarkan biasanya dalam format JSON. Namun, JSON pada dasarnya hanyalah sebuah string (teks), dan ketika di-parse ke dalam Dart, ia menjadi format yang tidak terstruktur, yaitu Map<String, dynamic>. Kita perlu membuat model Dart (seperti ProductEntry yang telah kita buat) untuk mengubah data yang tidak terstruktur ini menjadi objek Dart yang kaku, terstruktur, dan aman.

Konsekuensi jika kita tidak menggunakan model dan langsung bergantung pada Map<String, dynamic> sangat signifikan,

Validasi Tipe dan Null-Safety, ini adalah masalah terbesar. Jika kita menggunakan Map, kita akan mengakses data seperti data['price']. Kita tidak memiliki jaminan bahwa price benar-benar ada (mungkin null) atau bahwa tipenya adalah int. Jika kita mengharapkan int tapi malah mendapat String "1000", aplikasi kita akan crash saat runtime. Dengan model, kita mendefinisikan final int price;. Di dalam factory fromJson, kita secara eksplisit melakukan parsing dan validasi. Contohnya, pada model saya, rating: (json["rating"] as num?)?.toDouble() adalah cara yang aman untuk menangani angka yang bisa jadi desimal atau bahkan null tanpa menyebabkan crash.

Maintainability, Jika kita menggunakan data['product_name'] di 10 tempat berbeda dalam aplikasi, dan suatu hari backend mengubahnya menjadi data['name'], kita harus mencari dan mengganti di 10 tempat tersebut. Dengan model, kita hanya perlu mengubahnya di satu tempat: factory fromJson. Selain itu, kode kita menjadi jauh lebih bersih dan mudah dibaca (misalnya, product.name vs product['name']), yang juga mengurangi risiko typo.

2.  Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.

Dalam tugas ini, kedua package tersebut berfungsi untuk melakukan komunikasi HTTP (mengirim dan menerima data dari server Django), namun memiliki peran yang berbeda.
Package http, Ini adalah package dasar yang menyediakan fungsionalitas inti untuk membuat permintaan HTTP seperti GET, POST, PUT, dll. Ia adalah fondasi untuk segala komunikasi jaringan. Namun, http murni tidak secara otomatis mengelola status atau sesi.

Package pbp_django_auth (CookieRequest), Ini adalah wrapper khusus yang dibangun di atas package http. Fungsi utamanya adalah manajemen sesi secara otomatis. Saat kita berhasil login menggunakan request.post, server Django akan mengirimkan cookie (khususnya sessionid) dalam responsnya. CookieRequest secara cerdas menangkap cookie ini, menyimpannya di dalam instance-nya, dan yang paling penting, secara otomatis melampirkannya ke setiap permintaan berikutnya (seperti saat kita memanggil request.postJson di product_form.dart).

Perbedaan utamanya adalah: http hanya mengirim surat sedangkan CookieRequest mengirim surat sambil selalu membawa dan menunjukkan kartu identitas (session cookie) yang didapatnya saat login.

3.  Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

Kita perlu membagikan satu instance CookieRequest ke semua komponen karena instance itulah yang menyimpan status login kita (yaitu sessionid cookie).
Bayangkan CookieRequest sebagai kunci akses atau kartu ID. Saat kita login di lib/screens/login.dart, instance request di halaman itu menerima kunci dari server. Jika halaman lib/screens/product_form.dart membuat instance CookieRequest baru, itu ibarat membuat kunci akses baru yang masih kosong. Tentu saja, kunci kosong ini tidak akan dikenali oleh backend Django saat kita mencoba mengakses endpoint yang dilindungi @login_required.

Oleh karena itu, kita menggunakan Provider di lib/main.dart untuk membuat satu CookieRequest saja saat aplikasi pertama kali dijalankan. Kemudian, halaman mana pun, seperti login.dart atau product_form.dart, dapat mengakses instance yang sama persis menggunakan context.watch<CookieRequest>(). Ini memastikan bahwa kunci yang didapat saat login adalah kunci yang sama yang kita gunakan saat mencoba membuat produk baru.

4.  Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?

Agar Flutter (sebagai client) dapat berkomunikasi dengan Django (sebagai server), ada beberapa lapisan konfigurasi yang harus benar,
10.0.2.2 di ALLOWED_HOSTS, Saat kita menjalankan aplikasi di Emulator Android, localhost (atau 127.0.0.1) merujuk pada perangkat emulator itu sendiri, bukan komputer kita. Emulator Android menyediakan alamat IP khusus, 10.0.2.2, sebagai alias untuk merujuk ke localhost komputer (tempat server Django kita berjalan). Menambahkannya ke ALLOWED_HOSTS di settings.py Django adalah cara kita memberi tahu Django bahwa kita ercaya permintaan yang datang dari alamat alias emulator tersebut.

CORS (corsheaders): Browser menerapkan Same-Origin Policy yang ketat. Aplikasi Flutter web kita (berjalan di, misal, http://localhost:51234) memiliki origin yang berbeda dari server Django kita (http://localhost:8000). django-cors-headers adalah middleware Django yang menambahkan header HTTP khusus (seperti Access-Control-Allow-Origin) ke respons server. Header ini memberi tahu browser,  mengizinkan aplikasi dari http://localhost:51234 untuk mengambil data.

Pengaturan SameSite Cookie: Pengaturan ini memberi tahu browser kapan harus mengirim cookie. Untuk pengembangan cross-origin (Flutter Web ke Django), kita sering perlu mengatur SESSION_COOKIE_SAMESITE = 'None' agar browser mau mengirimkan sessionid kembali ke server, meskipun permintaannya berasal dari origin yang berbeda.

Izin Internet (Android): Aplikasi Android berjalan dalam sandbox dan secara default tidak diizinkan mengakses jaringan. Kita harus secara eksplisit meminta izin ini dengan menambahkan <uses-permission android:name="android.permission.INTERNET" /> ke dalam file AndroidManifest.xml. Ini adalah cara aplikasi kita meminta izin kepada sistem operasi Android untuk membuka koneksi ke server Django kita.

Konsekuensi jika salah konfigurasi:
Tanpa 10.0.2.2, emulator Android akan gagal terhubung (Connection Refused).
Tanpa CORS, aplikasi Flutter Web akan mendapatkan error CORS di konsol browser dan memblokir respons dari Django.
Tanpa izin internet, aplikasi Android akan crash atau gagal total saat mencoba melakukan panggilan jaringan apa pun.
Tanpa pengaturan SameSite yang benar, login mungkin tampak berhasil, tetapi cookie tidak akan dikirim kembali, sehingga permintaan ke halaman terproteksi (@login_required) akan gagal.

5.  Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
Mekanisme Pengiriman Data (Input hingga Tampil),
- Input (Flutter): Pengguna mengisi TextFormField di lib/screens/product_form.dart, yang memperbarui variabel state seperti _name, _price, dll.
- Validasi (Flutter): Pengguna menekan "Save". Fungsi _formKey.currentState!.validate() dipanggil untuk memeriksa validator di setiap TextFormField.
- Encoding (Flutter): Jika valid, data state (misal: _name, _price) dikemas ke dalam sebuah Map dan diubah menjadi string JSON menggunakan jsonEncode({...}).
- Pengiriman (Flutter): Instance CookieRequest yang dibagikan (request) memanggil request.postJson(...), mengirimkan string JSON tersebut sebagai body dari permintaan HTTP POST ke endpoint /create-flutter/. CookieRequest juga secara otomatis melampirkan cookie sessionid.
- Penerimaan (Django): Endpoint /create-flutter/ diarahkan ke view create_product_flutter di main/views.py.
- Otorisasi (Django): Dekorator @login_required memeriksa sessionid yang masuk, memverifikasi pengguna, dan mengizinkan permintaan masuk.
- Parsing (Django): View menggunakan json.loads(request.body) untuk mengubah string JSON kembali menjadi data Python.
- Proses (Django): Data divalidasi, dibersihkan (menggunakan strip_tags), dan sebuah objek Product baru dibuat. new_product.save() menulis data ini ke database.
- Respons (Django): Django mengirimkan JsonResponse({"status": "success", ...}) kembali ke Flutter.
- Konfirmasi (Flutter): onPressed di product_form.dart menerima respons ini, memeriksa if (response['status'] == 'success'), lalu menampilkan SnackBar "Produk baru berhasil disimpan!" dan mengarahkan pengguna kembali ke halaman menu.
- Penampilan (Flutter): Saat pengguna menekan "All Products", ProductListPage memanggil endpoint /json/. Karena produk baru tadi sudah ada di database, view show_json sekarang menyertakannya dalam daftar JSON, yang kemudian ditampilkan oleh Flutter.

6.  Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
Proses ini adalah inti dari interaksi aman antara Flutter dan Django:
- Register: Pengguna mengisi form di lib/screens/register.dart. Data dikirim sebagai JSON ke /auth/register/. View register di authentication/views.py menggunakan json.loads dan User.objects.create_user untuk membuat akun. Ia tidak melakukan login, hanya membuat akun dan mengembalikan status sukses.
- Login: Pengguna mengisi form di lib/screens/login.dart. Menariknya, di sini kita menggunakan request.post (bukan postJson). Ini mengirim data sebagai Form Data (bukan JSON), yang sesuai dengan view login di authentication/views.py yang mengharapkan data dari request.POST.
- Proses Login (Django): View login memanggil authenticate() untuk memeriksa kredensial. Jika berhasil, ia memanggil auth_login(request, user). Ini adalah langkah kuncinya: Django membuat sesi di database-nya dan mengirimkan header respons Set-Cookie yang berisi sessionid yang unik.
- Penyimpanan (Flutter): CookieRequest (yang melakukan pemanggilan request.post) menerima respons ini, secara otomatis mengekstrak sessionid dari header, dan menyimpannya secara internal. Ia juga mengatur request.loggedIn = true.
- Tampilan Menu (Flutter): Setelah response['status'] == true, Flutter memanggil Navigator.pushReplacement untuk pindah ke MyHomePage. Sekarang, saat pengguna menekan "Tambah Produk", request.postJson di product_form.dart dijalankan. CookieRequest secara otomatis menambahkan cookie sessionid yang telah disimpannya ke header permintaan. View create_product_flutter di Django melihat cookie ini, dan dekorator @login_required mengonfirmasi bahwa sesi tersebut valid, sehingga mengizinkan akses.
- Logout: Pengguna menekan "Logout". request.logout(".../auth/logout/") dipanggil. View logout di authentication/views.py memanggil auth_logout(request), yang menghapus sesi di sisi Django. CookieRequest juga menghapus sessionid di sisi Flutter. Aplikasi kemudian diarahkan kembali ke LoginPage.

7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).
Berikut adalah Implementasi Step-by-Step saya, 
- Saya menggunakan model Product di main/models.py sebelumnya yang sudah dibuat dan langsung membuat model Dart yang sesuai di lib/models/product_entry.dart agar Flutter mengerti struktur data ini (menggunakan converter).
- Sebelum menyentuh UI Flutter, saya memastikan backend dapat menyajikan data. Saya membuat view show_json di main/views.py dan mendaftarkannya ke /json/ di main/urls.py. Saya mengujinya langsung di browser untuk memastikan data JSON muncul.
- Dengan API yang berfungsi, saya beralih ke Flutter. Saya membuat lib/screens/product_entry_list.dart menggunakan FutureBuilder untuk memanggil /json/. Saya membuat lib/widgets/product_entry_card.
- Sekarang saya perlu mengamankan aplikasi. Di Django, saya membangun app authentication dengan tiga view: login, register, dan logout. Di Flutter, saya membuat lib/screens/login.dart dan lib/screens/register.dart. Saya mengonfigurasi lib/main.dart untuk menggunakan Provider agar bisa membagikan satu CookieRequest. Saya mengimplementasikan logika onPressed untuk register (menggunakan postJson) dan login (menggunakan post agar sesuai dengan request.POST di view Django). Saya menambahkan tombol "Logout" di lib/widgets/product_card.dart dan mengaturnya di lib/screens/menu.dart.
- Setelah login berfungsi, saya menambahkan fitur Create. Di Django, saya membuat view create_product_flutter di main/views.py, melindunginya dengan @login_required, dan mendaftarkannya ke /create-flutter/. Di Flutter, saya membuat lib/screens/product_form.dart dan menghubungkannya dari lib/screens/menu.dart.
Saya mengimplementasikan tombol Save, menggunakan request.postJson. Karena CookieRequest dibagikan, ini secara otomatis mengirim cookie login dan berhasil melewati @login_required.
- Saya melakukan testing pada lib/screens/product_detail.dart dan sadar saya belum menampilkan semua atribut. Saya menambahkan userId dan userUsername.
Ini mengungkap bug yang terjadi yaitu, Penjual: Tidak diketahui. Saya sadar show_json di main/views.py tidak mengirim user_username. Saya memperbaikinya.
Setelah show_json bisa mengakses request.user (karena saya menambahkan @login_required), saya sadar saya bisa dengan mudah menambahkan filter My Products dengan menambahkan if request.GET.get('filter') == 'my'. Saya kemudian memperbarui lib/screens/product_entry_list.dart untuk menerima filterType dan mengubah URL panggilannya, yang akhirnya menyelesaikan fungsionalitas filter.