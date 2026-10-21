# Flutter LaundryCare

LaundryCare adalah aplikasi sederhana untuk mencatat pesanan laundry dan memantau status pengerjaannya. Aplikasi ini dibuat sebagai praktikum untuk menerapkan **State dan Interaksi Pengguna** pada Flutter.

## Fitur

- Memasukkan nama pelanggan.
- Memasukkan berat laundry dalam kilogram.
- Menghitung perkiraan biaya secara otomatis.
- Menambahkan pesanan laundry.
- Menampilkan daftar pesanan.
- Mengubah status pesanan dari Diproses menjadi Selesai.
- Menampilkan jumlah pesanan dan pesanan yang selesai.

## Teknologi

- Flutter
- Dart
- Material Design

## Konsep yang Digunakan

- `StatefulWidget` untuk mengelola tampilan dinamis.
- `setState()` untuk memperbarui data pesanan.
- `TextField` untuk memasukkan data pelanggan dan berat laundry.
- `TextEditingController` untuk mengelola input.
- `List` untuk menyimpan daftar pesanan.
- `AnimatedContainer` untuk memberikan perubahan tampilan dengan animasi.

## Cara Menjalankan

1. Pastikan Flutter sudah terpasang.
2. Clone repository ini.
3. Masuk ke folder project.
4. Jalankan perintah berikut:

```bash
flutter pub get
flutter run
```

## Ketentuan Biaya

Perhitungan biaya menggunakan tarif Rp7.000 per kilogram. Total biaya dihitung berdasarkan berat laundry yang dimasukkan.

## Catatan

Data pesanan masih disimpan sementara di dalam aplikasi dan belum menggunakan database. Data akan hilang ketika aplikasi dijalankan ulang.

## Tujuan

Memahami penerapan state, input pengguna, perhitungan otomatis, dan perubahan status pada aplikasi sederhana berbasis Flutter.

