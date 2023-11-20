1. Judul README atau Nama Aplikasi TK (hint: bisa meniru web app)
LiteraLandMobile


 2. Pipeline Status (note: bisa ditambahkan saat Tahap II)


 3. Tautan APK (note: bisa ditambahkan saat Tahap II)


 4. Daftar Anggota (hint: bisa meniru web app)
- Caesar Syahru Ramadhan
- M. Alif Al Hakim
- Farrel Muhammad Hanau
- Michelle Angelica Santoso
- Salma Nurul ‘Aziz




 5. Deskripsi Aplikasi (hint: bisa meniru web app)


Dalam era digital saat ini, membaca buku tetap menjadi salah satu kegiatan yang paling digemari banyak orang. Namun, dengan begitu banyaknya koleksi buku yang ada, seringkali pembaca kesulitan dalam mengingat halaman terakhir yang mereka baca, serta berdiskusi dan menyimpan buku favorit. Oleh karena itu, dibutuhkan sebuah aplikasi yang mampu menyediakan solusi untuk permasalahan tersebut.


LiteraLand adalah aplikasi koleksi buku yang memungkinkan pengguna untuk membaca buku pada halaman web. Aplikasi ini menyediakan fitur yang dapat mendukung kegiatan membaca pengguna seperti sistem pencarian dan koleksi buku, pembatas buku, serta forum diskusi/review. Selain itu, aplikasi ini juga memungkinkan untuk membuat ranking buku sesuai personalisasi masing-masing.


 6. Daftar Modul dan Pengembang (hint: bisa meniru web app)
- Modul Browse Buku 🔎
    Pada modul ini akan ditampilkan semua buku yang terdapat di database projek. Selain itu, pada modul ini user dapat mengirimkan permintaan untuk menambahkan buku di database sehingga mereka dapat menambahkan buku tersebut ke koleksi.
- 🔖 Modul Koleksi Buku 🔖
    Pada modul ini user dapat menambahkan semua buku yang ingin mereka tambahkan ke daftar koleksi. User dapat menambahkan buku dengan meng-click buku pada halaman browse buku lalu menambahkannya ke daftar koleksi dengan menekan tombol Add to Collections. Pada modul ini user dapat menyimpan progres baca, status baca, dan rating dari buku yang ada pada daftar koleksi mereka. Selain itu, mereka dapat membaca buku yang ada dalam daftar koleksi mereka.
- ⭐ Model Ranking ⭐
    Pada modul ini setiap user dapat memposting daftar buku favorite menurut pendapat mereka. Selain itu, pada modul ini user juga dapat melihat list buku favorite dari user lain sehingga dapat menjadi referensi untuk membaca buku lain.
- 📃 Model Review Buku 📃
    Pada modul ini setiap user dapat memposting review mengenai suatu buku. User dapat memberikan komentar atau pendapat dan rating dari 1 sampai 5 untuk buku yang mereka review. User juga dapat melihat review dari user lain mengenai buku tersebut sehingga dapat menjadi referensi dalam memilih buku.
- 💎 Modul Admin 💎
    Pada modul ini admin akan menerima pesan request yang telah dikirimkan user pada modul Browse Buku. Admin dapat menambahkan buku yang telah di-request oleh user ke database projek sehingga semua user dapat menambahkan buku ke daftar koleksi, melakukan review terhadap buku tersebut, atau memasukkannya ke list rekomendasi buku.


 7. Daftar Peran Pengguna (hint: bisa meniru web app)
+ Guest
- Pengguna yang belum memiliki akun atau belum login ke website
- User Guest bisa mengakses halaman browse buku untuk melihat daftar buku yang ada pada database
- User Guest juga bisa mengakses halaman detail buku setelah mengeklik judul buku pada halaman browse buku
- User Guest juga bisa mengakses halaman rankingBuku untuk melihat list-list buku dari user lain (Guest tidak bisa menambahkan list buku sendiri)


+ User
- Pengguna yang sudah memiliki akun dan sudah login ke website
- User bisa mengakses fitur Koleksi buku 
- User bisa membaca buku yang terdapat dalam daftar koleksi
- User bisa mengakses halaman rankingBuku dan mempost list buku favorit-nya
- User bisa melakukan permintaan/request pada halaman browse buku untuk menambahkan buku baru ke database
- User bisa mengakses halaman review buku dan memposting review buku sendiri


+ Admin
- Pengguna yang memiliki seluruh `hak akses` dari `user` dan hak akses khusus
- Admin dapat menerima pesan request buku dari user.
- Admin dapat menambahkan buku berdasarkan request user ke database


8. Alur Pengintegrasian dengan Aplikasi Web (hint: bisa mencontoh penjelasan di Tutorial)
    Menambahkan dependensi http ke proyek. dependensi ini digunakan untuk bertukar HTTP request.
    1. Membuat model sesuai dengan respons dari data yang berasal dari web service tersebut.
    2. Membuat http request ke web service menggunakan dependensi http.
    3. Mengkonversikan objek yang didapatkan dari web service ke model yang telah kita buat di langkah kedua.
    4. Menampilkan data yang telah dikonversi ke aplikasi dengan FutureBuilder.

9. Tautan Berita Acara Kerja Kelompok (note: template berita acara yang ada di Scele bisa diunggah ke Google Drive atau OneDrive, kemudian tautan Google Drive atau OneDrive tersebut ditambahkan ke README)
    ristek.link/BeritaAcaraC07