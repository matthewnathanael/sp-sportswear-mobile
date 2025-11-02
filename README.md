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