# RumahKu

Aplikasi manajemen aset rumah tangga **Offline-First & Multi-Platform (Android, iOS/PWA, PC Windows/macOS/Linux, dan Web)** dengan prinsip **Rp 0 (tanpa biaya langganan / tanpa kartu kredit)**.

> *"Data semua barang di rumah agar dapat diketahui kemana uangmu, seberapa bermanfaat barangnya, mengelola kendaraan, perpustakaan buku, brankas berkas penting, dan yang paling utama — mendata barang pindahan."*

---

## Fitur Utama (Unified Asset Architecture)

Seluruh barang rumah, kendaraan, buku, dan berkas tersimpan dalam satu arsitektur aset terpadu (*Unified Asset*) dengan hirarki lokasi bersarang (`Rumah → Ruangan → Lemari/Rak/Brankas → Kardus → Barang`):

- **Inventaris Rumah & Hirarki Lokasi *(M1 — Aktif)***: Pohon lokasi bersarang tanpa batas, pencatatan harga beli/nilai taksiran/garansi/kondisi, lampiran foto barang & struk terkompresi, pencarian cepat, dan layout adaptif (Mobile BottomBar + Desktop/Web Sidebar).
- **Offline-First + Cloud Sync Keluarga *(M1 — Aktif)***: Database lokal **Drift (SQLite Native / Web WASM)** + **Outbox & Delta Sync** ke **Supabase Free Tier** (PostgreSQL + RLS + Private Storage 1 GB). Tetap berjalan 100% lokal tanpa login paksa bila kredensial cloud belum diisi.
- **Mode Pindahan & Stiker QR *(M2 — Aktif)***: Proyek pindahan, kardus/box ber-QR (cetak PDF A4 & thermal 80/58 mm), status kardus (`Packing → Siap Angkut → Di Truk → Sampai → Dibongkar`), *bulk move* per barang atau per lokasi/rak, scan QR lintas platform, bongkar otomatis ke ruangan tujuan, dan ekspor Manifest PDF/CSV.
- **Analitik Keuangan & Kebermanfaatan Hybrid *(M3)***: Dasbor *"Kemana Uangmu"*, *Cost-per-Use*, deteksi barang nganggur (*Declutter*), dan grafik `fl_chart`.
- **Modul Garasi / Kendaraan Indonesia *(M4)***: Pelacak pajak STNK 1 & 5 tahunan, BPKB, asuransi, servis (tanggal & odometer km), log BBM (km/L), TCO, dan barang di dalam kendaraan.
- **Perpustakaan Buku (Scan ISBN + AI) & Brankas Berkas *(M5)***: Pipeline ISBN (Open Library & Google Books → Gemini AI Free Tier BYOK), progres baca & *Tsundoku Index*, pelacakan pinjam-meminjam, serta Brankas Berkas khas Indonesia (KTP/KK/Paspor/SHM/Ijazah/Polis) dengan kunci Biometrik/PIN & pencarian OCR.
- **Input Cepat AI Foto Barang & Struk *(M6)***: Ekstraksi otomatis foto barang/struk via Gemini Vision BYOK & backup penuh ZIP.

---

## Menjalankan Proyek

### 1. Mode Offline Lokal (Tanpa Akun Cloud)
```bash
flutter pub get
dart run build_runner build
flutter run
```
Aplikasi otomatis membuat rumah tangga lokal (**"Rumah Utama"**) menggunakan SQLite Drift tanpa memerlukan kredensial cloud.

### 2. Mengaktifkan Cloud Sync Keluarga (Supabase Free Tier — Rp 0)
1. Buat proyek gratis di [Supabase](https://supabase.com) (tanpa kartu kredit).
2. Jalankan SQL migrasi [0001_initial_schema.sql](supabase/migrations/0001_initial_schema.sql) di **SQL Editor** Supabase.
3. Salin `.env.example` menjadi `.env` lalu isi `SUPABASE_URL` dan `SUPABASE_ANON_KEY`.
4. Jalankan:
   ```bash
   flutter run --dart-define-from-file=.env
   ```
5. *(Opsional)* Tambahkan `SUPABASE_URL` dan `SUPABASE_ANON_KEY` ke **GitHub Repository Secrets** agar workflow `.github/workflows/supabase_keepalive.yml` otomatis menjaga proyek gratis dari *auto-pause 7 hari*.

### 3. Verifikasi & Pengujian
```bash
chmod +x scripts/verify.sh
./scripts/verify.sh
```

---

## Distribusi Rp 0 ke 4 Lingkungan
- **Web & iOS (PWA):** `flutter build web` → deploy gratis ke GitHub Pages / Cloudflare Pages; di iPhone/iPad buka lewat Safari lalu pilih **"Add to Home Screen"** (offline via Drift WASM + Service Worker, tanpa biaya Apple Developer).
- **Android:** `flutter build apk --release` → install langsung ke perangkat keluarga.
- **PC (Windows / macOS / Linux):** `flutter build windows` / `macos` / `linux`.
