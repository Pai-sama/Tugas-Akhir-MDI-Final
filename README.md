# 🏡 Hidden Gem Village App

> **Aplikasi Edukasi Interaktif Eksplorasi Desa Wisata & Budaya Unik di Indonesia**

Aplikasi **Hidden Gem Village App** dirancang sebagai platform edukasi digital interaktif berbasis mobile yang berfokus khusus pada penemuan dan pelestarian desa adat serta desa wisata unik di Indonesia. Dengan menggunakan pendekatan media digital interaktif, aplikasi ini bertujuan untuk menjembatani kesenjangan informasi mengenai keindahan alam, kearifan lokal, adat istiadat, dan sejarah desa-desa tradisional di Nusantara yang sering kali luput dari perhatian wisatawan domestik maupun mancanegara.

---

## 🎨 Cuplikan Visual Antarmuka (Aesthetic Preview)

Desain aplikasi menggunakan pendekatan **Modern-Organic Visual** yang memadukan keindahan alam pedesaan dengan kemudahan interaksi modern:
*   **Warna Primer (Emerald Green - `#076643`)**: Melambangkan kelestarian alam dan bentang hijau pedesaan Indonesia.
*   **Warna Latar (Warm Cream - `#FAF6F0`)**: Memberikan kesan bersahabat (*earthy*), hangat, dan premium.
*   **Warna Aksen (Warm Amber - `#FFAE19`)**: Penanda elemen penting seperti rating bintang dan lencana pencapaian.

---

## ✨ Fitur Utama Aplikasi

1.  **Splash & Onboarding Screen (Layar Pembuka)**:
    *   Tampilan menyambut dengan logo flat vector yang elegan, gradasi warna alam yang menenangkan, serta tombol aksi cepat untuk langsung memulai perjalanan penjelajahan.
2.  **Explorer Dashboard (Halaman Beranda)**:
    *   **Fitur Pencarian Pintar**: Filter desa secara dinamis saat mengetik di bilah pencarian.
    *   **Kategori Pilihan Dinamis**: Tombol chip pilihan kategori desa (*Semua*, *Desa Adat*, *Wisata Alam*) yang memfilter daftar desa secara real-time.
    *   **Featured Hero Card**: Menyorot desa unggulan (seperti Desa Penglipuran) dengan visual megah, rating bintang, dan status favorit.
    *   **Grid Rekomendasi**: Menampilkan daftar desa wisata lainnya secara responsif dengan transisi animasi halus.
    *   **Banner Edukasi Mulai Kuis**: Banner ajakan interaktif untuk menguji wawasan pengguna dengan ikon kuis yang premium.
3.  **Detail Exploration View (Detail Desa)**:
    *   **Hero Image Transition**: Foto desa dengan resolusi tinggi yang memenuhi latar belakang di balik tombol kembali melingkar transparan.
    *   **Tentang Desa**: Informasi naratif komprehensif mengenai profil desa.
    *   **Sejarah Singkat (Timeline)**: Linimasa vertikal interaktif yang menceritakan era kerajaan hingga zaman modern dari desa bersangkutan.
    *   **Galeri Foto**: Komponen galeri geser horizontal untuk melihat sudut keindahan desa secara visual.
    *   **Kebudayaan Lokal**: Kartu-kartu adat istiadat khas (contoh: hukum adat *Awig-Awig* dan arsitektur *SAMA*) dengan ikon representatif yang menawan.
    *   **Sticky CTA**: Tombol melayang di bagian bawah untuk langsung memulai kuis kebudayaan desa tersebut.
4.  **Culture Quiz Mode (Kuis Kebudayaan)**:
    *   **Indikator Progres Dinamis**: Garis progres linear (*progress bar*) dan persentase penyelesaian soal yang terus diperbarui.
    *   **Visual Question Card**: Kartu soal yang dilengkapi ilustrasi riil tentang adat Indonesia.
    *   **Real-Time Answer Validation**: Tombol pilihan ganda interaktif:
        *   Jawaban **Benar** langsung berubah menjadi **hijau** disertai ikon centang.
        *   Jawaban **Salah** berubah menjadi **merah** disertai ikon silang, sekaligus otomatis menyoroti jawaban yang benar dengan warna hijau lembut secara real-time.
5.  **Quiz Evaluation & Achievement (Hasil Kuis)**:
    *   **Circular Score Gauge**: Grafik melingkar besar yang menampilkan skor akhir (skala 0 - 100) berhiaskan lencana bintang emas melayang.
    *   **Umpan Balik Adaptif**: Judul ucapan selamat yang menyesuaikan tingkat pemahaman materi oleh pengguna.
    *   **Statistik Jawaban**: Dua kartu data terpisah yang menghitung jumlah jawaban **BENAR** dan **SALAH**.
    *   **Lencana Pencapaian**: Kartu **"Pencapaian Baru!"** bernuansa hijau ramah lingkungan yang memberi penghargaan lencana *'Penjelajah Desa'* tingkat 1.
6.  **Saved/Bookmarks (Desa Favorit)**:
    *   Daftar desa-desa pilihan yang disimpan oleh pengguna agar bisa diakses kembali kapan pun secara cepat, dilengkapi dengan tampilan kosong (*empty state*) yang didesain estetik bila belum ada desa favorit yang disimpan.

---

## 🛠️ Teknologi & Libs yang Digunakan

*   **Framework**: Flutter (v3.x atau terbaru)
*   **Language**: Dart
*   **State Management**: `provider` (v6.1.2) - Manajemen state terpadu untuk performa responsif dan bebas lag.
*   **Design System**: Material 3 dengan Kustomisasi Tema Organik (`lib/theme/app_theme.dart`).
*   **Typography**: Google Fonts Inter.

---

## 🚀 Cara Instalasi & Menjalankan Proyek Secara Lokal

### Prasyarat
*   Sudah menginstal **Flutter SDK** di komputer Anda.
*   Menyiapkan emulator (Android/iOS) atau browser Google Chrome.

### Langkah-langkah
1.  **Clone Repositori**:
    ```bash
    git clone https://github.com/USERNAME/hidden_gem_village.git
    cd hidden_gem_village
    ```
2.  **Unduh Dependensi**:
    ```bash
    flutter pub get
    ```
3.  **Jalankan Aplikasi**:
    *   *Melalui perangkat Chrome*:
        ```bash
        flutter run -d chrome
        ```
    *   *Melalui perangkat emulator/fisik umum*:
        ```bash
        flutter run
        ```

---

## 📂 Struktur Folder Proyek

```markdown
lib/
├── models/
│   ├── village.dart            # Struktur data desa wisata
│   └── quiz.dart               # Struktur data kuis pilihan ganda
├── state/
│   └── app_state.dart          # Pengelola state aplikasi (favorit, kuis, pencarian)
├── theme/
│   └── app_theme.dart          # Konfigurasi sistem warna & font
├── screens/
│   ├── splash_onboarding_screen.dart # Layar sambutan onboarding
│   ├── main_navigation_wrapper.dart   # Navigasi tab bar utama
│   ├── home_screen.dart        # Halaman utama eksplorasi
│   ├── detail_screen.dart      # Eksplorasi profil desa wisata
│   ├── quiz_screen.dart        # Kuis interaktif wawasan
│   ├── quiz_result_screen.dart # Skor evaluasi kuis
│   └── saved_screen.dart       # Daftar desa yang difavoritkan
└── main.dart                   # Entry point aplikasi
```

---

Made with ❤️ for Indonesia's Rich Cultural Heritage.
