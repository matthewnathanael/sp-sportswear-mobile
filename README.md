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