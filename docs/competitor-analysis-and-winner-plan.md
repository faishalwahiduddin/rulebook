# Analisis 10 Kompetitor & Master Plan "Market Winner" — RuleBook

Dokumen ini disusun oleh Autonomous Lead Software Architect & Principal Product Engineer untuk mentransformasikan **RuleBook** menjadi produk nomor satu (Market Winner) di kategori aplikasi buku saku digital peraturan, hak hukum, kepatuhan (compliance), dan panduan keselamatan offline.

---

## 1. Benchmarking 10 Kompetitor (Direct & Indirect)

| # | Kompetitor | Kategori & Tipe | Core Capabilities & Fitur Unggulan | Kelemahan Utama (Bottleneck UX/UI) | Fitur Terbaik yang Diadopsi RuleBook |
|---|------------|-----------------|-----------------------------------|-----------------------------------|-------------------------------------|
| 1 | **JDIHN Mobile (BPHN Kemenkumham)** | Direct (Statute Database) | Database komprehensif seluruh UU, PP, Perpres, Permen, dan Perda resmi RI; pencarian nomor & tahun regulasi; unduh PDF asli. | Bahasa hukum kaku (*legalese*), UI birokratis lambat, wajib online untuk cari dokumen, tidak ada intisari praktis apa yang boleh/dilarang. | Basis legalitas resmi (nomor pasal & UU yang akurat), penelusuran hierarki peraturan. |
| 2 | **Hukumonline Mobile & Klinik** | Direct/Indirect (Legal Portal & Q&A) | Tanya jawab hukum praktis (*Klinik Hukumonline*), artikel analisis kasus, kurasi isu regulasi terkini. | Wajib login/registrasi, *paywall* ketat untuk database pasal, tidak mendukung akses cepat *offline-first*, navigasi berat. | Format tanya-jawab ramah orang awam, intisari hak & sanksi praktis, rujukan silang pasal. |
| 3 | **SuperApp Polri Presisi / ETLE Korlantas** | Direct (Traffic Law & Enforcement) | Cek status tilang ETLE, informasi pasal pelanggaran lalin, denda tilang maksimal, panduan perpanjangan SIM/STNK. | Sering server *down*, wajib KYC NIK & nomor rangka, tidak ada panduan SOP interaktif saat pengendara distop razia polisi. | Katalog lengkap pasal tilang UU LLAJ No. 22/2009, kalkulator akumulasi denda, panduan hak saat razia. |
| 4 | **Simulasi Pesangon Kemnaker (pesangon.kemnaker.go.id)** | Direct (Labor Law Calculator) | Kalkulasi matematis pesangon, UPMK (Uang Penghargaan Masa Kerja), dan UPH sesuai PP 35/2021 & UU Cipta Kerja berdasarkan alasan PHK. | Hanya berupa web form sederhana tanpa aplikasi mobile, tidak terintegrasi aturan lembur/cuti/THR, tidak bisa dipakai offline. | Mesin kalkulasi formula matematis PP 35/2021 (Pesangon, UPMK, UPH 15%) dan THR prorata. |
| 5 | **LawStack (Global Benchmark)** | Direct (Statute Reader) | Arsitektur pembaca undang-undang offline nomor satu di AS; indeks pasal hierarkis kilat; bookmark & anotasi personal. | Desain monokrom kaku, tidak memiliki kalkulator denda/hak, konten murni teks statis tanpa panduan situasi nyata. | Struktur navigasi pasal super cepat, arsitektur offline-first, catatan pribadi per pasal (*in-line notes*). |
| 6 | **Lexcalc Pro** | Direct (Legal Calculator) | Kalkulator multi-parameter untuk denda hukum, perhitungan bunga statutori, tenggat waktu perdata/pidana. | UI kompleks dan intimidatif bagi non-ahli hukum, aplikasi berbayar terpisah per modul hukum. | Desain kartu hasil interaktif dengan rincian formula transparan dan tombol salin ke clipboard. |
| 7 | **Buku Saku KUHP & KUHAP Mobile** | Direct (Pocket Statute) | Buku saku teks pasal KUHP, KUHAP, dan KUHPerdata untuk mahasiswa & praktisi hukum; pencarian nomor pasal. | Banyak iklan mengganggu, belum diperbarui ke KUHP Baru (UU 1/2023), teks mentah tanpa Do's & Don'ts. | Pencarian instan nomor pasal, katalog kategori cepat, penanda bookmark favorit. |
| 8 | **BPKN Konsumen Cerdas & SiPeka YLKI** | Direct (Consumer Protection) | Panduan hak konsumen (UU No. 8/1999), prosedur komplain garansi dan penipuan e-commerce, mekanisme BPSK. | Informasi terpencar, form aduan sering error, tidak menyediakan draf surat somasi/keberatan siap pakai. | SOP penanganan sengketa konsumen, hak retur barang rusak, draf somasi mandiri ringkas. |
| 9 | **HSE / K3 Pocket Safety Guide** | Direct (Workplace Safety SOP) | Buku panduan keselamatan kerja, standar APD, SOP evakuasi darurat (kebakaran, gempa, kecelakaan kerja). | Terkunci di software korporat internal atau buku fisik, tidak menghubungkan hak santunan BPJS Ketenagakerjaan. | Checklist audit kepatuhan K3 interaktif dengan *progress score*, SOP darurat langkah demi langkah. |
| 10 | **UU PDP & Cyber Compliance Pocket** | Direct (Privacy & Cyber Rights) | Rangkuman kewajiban pengendali data (UU No. 27/2022) dan delik aduan UU ITE (UU No. 1/2024); denda sanksi administratif. | Berupa dokumen PDF tebal puluhan halaman, tidak ada simulasi risiko delik pasal ITE. | Matriks risiko delik UU ITE (Pasal 27, 28, 29), checklist audit hak subjek data, SOP 72 jam kebocoran data. |

---

## 2. Peta Arsitektur Layar & Aliran Data (Data Flow Breakdown)

### A. Displayed Data (Visual Elements, Metrics & Tables)
- **Dashboard & Katalog**: Search bar real-time, badge kategori dinamis, kartu aturan dengan indikator tingkat denda/sanksi, chip kata kunci populer.
- **Detail Aturan**: Badge dasar hukum resmi, box sanksi/hak berwarna penekanan, daftar butir *Do's* (hijau) dan *Don'ts* (merah), catatan pribadi interaktif.
- **Multi-Calculator Suite**:
  - *Tab Upah Lembur*: Gaji bulanan, jam kerja hari biasa vs hari libur, hasil upah lembur resmi PP 35/2021 dengan visual rincian jam ke-1 dan jam ke-2+.
  - *Tab Kompensasi PHK / Pesangon*: Masa kerja, gaji pokok + tunjangan tetap, alasan PHK (Efisiensi, Pensiun, Pelanggaran, Force Majeure), output rincian: Uang Pesangon + UPMK + Penggantian Hak.
  - *Tab THR Keagamaan*: Masa kerja (bulan), upah bulanan, kalkulasi THR prorata vs penuh.
  - *Tab Denda Tilang LLAJ*: Multi-select pelanggaran lalu lintas UU 22/2009, estimasi denda maksimal kumulatif, pasal pelanggaran, slip tilang panduan.
  - *Tab Simulasi UU ITE*: Parameter kasus pencemaran vs kritik, berita bohong, ancaman siber, dengan ambang sanksi penjara dan denda maksimal.
- **Panduan Situasi Darurat & SOP**: Kartu langkah-demi-langkah (step-by-step timeline) untuk situasi razia, PHK sepihak, sengketa barang, kebocoran data, kecelakaan kerja.
- **Audit & Compliance Checklists**: Checklist interaktif per modul dengan persentase kepatuhan (*compliance score gauge*).

### B. Stored Data (Offline Local Storage Entity Schema)
- `bookmarks`: Set string ID aturan yang disimpan.
- `rule_notes`: Map `<ruleId, noteText>` catatan pribadi pengguna.
- `checklist_states`: Map `<checklistId_itemId, bool>` status centang audit mandiri.
- `calculator_history`: Riwayat kalkulasi terakhir untuk mempermudah perbandingan.
- `user_settings`: Preferensi tampilan dan filter default.

### C. Processed Data (Computation Logic & Validations)
- **Formula Lembur**: Upah sejam = `Upah Bulanan / 173`. Hari kerja: Jam ke-1 = `1.5x`, Jam berikutnya = `2x`. Hari libur: Jam 1-8 = `2x`, Jam 9 = `3x`, Jam 10-12 = `4x`.
- **Formula Pesangon & UPMK**: Pengali masa kerja per Pasal 40-52 PP 35/2021 disesuaikan dengan koefisien alasan PHK (0.5x, 0.75x, 1x, atau 1.75x).
- **Formula THR**: Jika masa kerja < 12 bulan: `(Masa Kerja / 12) * Upah Bulanan`; jika >= 12 bulan: `1 * Upah Bulanan`.
- **Validasi (§VAL)**: Validasi angka non-negatif, batasan nominal realistis, sanitasi pencarian teks bebas (maks 100 karakter, cegah XSS injection), sanitasi input catatan lokal.

---

## 3. Site Map & Navigasi Target "Market Winner"

```
[NavigationShell (5 Bottom Tabs)]
├── Tab 1: / (Katalog Aturan)
│    ├── Search & Filter Modal (Kategori, Sanksi, Hak, SOP)
│    ├── Quick Category Horizontal Chips
│    ├── Rule Card List
│    └── Detail Rule Screen (/rule/:id)
│         ├── Legal Basis & Official Citations
│         ├── Do's & Don'ts Cards
│         ├── In-line Private Note Editor (§VAL)
│         └── Share / Copy Ringkasan Aturan
├── Tab 2: /simulasi (Multi-Calculator Hub)
│    ├── Sub-tab 1: Upah Lembur (Hari Kerja & Libur PP 35/2021)
│    ├── Sub-tab 2: Pesangon & Kompensasi PHK
│    ├── Sub-tab 3: Tunjangan Hari Raya (THR) Prorata
│    ├── Sub-tab 4: Akumulasi Denda Tilang (UU LLAJ 22/2009)
│    └── Sub-tab 5: Matriks Sanksi Siber & UU ITE (UU 1/2024)
├── Tab 3: /sop (Panduan Situasi Darurat & SOP)
│    ├── Razia Lalu Lintas & Tilang Polisi
│    ├── Menghadapi PHK Sepihak Tanpa Pesangon
│    ├── Komplain Konsumen & Somasi Barang Cacat
│    ├── Respon 72 Jam Kebocoran Data Pribadi (UU PDP)
│    └── Penanganan Darurat Kecelakaan Kerja & K3
├── Tab 4: /checklist (Audit Kepatuhan & Checklist Mandiri)
│    ├── Checklist Kelayakan & Dokumen Berkendara
│    ├── Checklist Hak Normatif Ketenagakerjaan
│    ├── Checklist K3 & Keselamatan Kerja
│    └── Checklist Privasi Data & Keamanan Digital
└── Tab 5: /bookmarks (Aturan & Catatan Tersimpan)
     ├── Filter Berdasarkan Kategori
     ├── Akses Cepat Aturan Penting
     └── Manajemen Catatan Pribadi
```

---

## 4. Technical Implementation Roadmap

1. **Data Layer (`lib/core/models/`, `lib/core/storage/`)**:
   - Perluas `RuleCategory` (tambahkan Kategori Baru: Etika Publik & Pidana).
   - Perbarui model `RuleItem` dan buat model `SopGuide` dan `ComplianceChecklist`.
   - Perluas `RulesDatabase` dengan 30+ aturan hukum terlengkap, 5 SOP darurat lengkap, dan 4 modul audit checklist.
   - Perbarui `LocalStorageService` untuk menyimpan status checklist dan riwayat kalkulasi.
2. **Logic & Provider Layer (`lib/core/providers/`)**:
   - Provider state untuk kalkulator Pesangon, THR, Lembur, dan Tilang.
   - Provider state untuk Checklist Kepatuhan interaktif dengan *score gauge*.
   - Provider state untuk SOP Darurat & filtering.
   - Validasi ketat (§VAL) pada seluruh input kalkulator dan form catatan.
3. **Routing Layer (`lib/core/router/app_router.dart`, `navigation_shell.dart`)**:
   - Daftarkan rute 5 tab utama: `/`, `/simulasi`, `/sop`, `/checklist`, `/bookmarks`, dan `/settings`.
4. **UI Presentation Layer (`lib/features/`)**:
   - `lib/features/catalog/`: UI katalog modern dengan chip filter dan kartu interaktif.
   - `lib/features/calculator/`: UI tab kalkulator terlengkap (Lembur, Pesangon, THR, Tilang, UU ITE) dengan kartu hasil yang bisa disalin ke clipboard.
   - `lib/features/sop/`: Layar panduan situasi darurat dengan *step-by-step expandable cards*.
   - `lib/features/checklist/`: Layar checklist audit kepatuhan interaktif dengan progress indicator.
   - `lib/features/bookmarks/`: Layar bookmark dan catatan yang terintegrasi.
   - `lib/features/settings/`: Layar pengaturan data lokal, disclaimer hukum, dan informasi aplikasi.
5. **Quality Verification**:
   - Jalankan `flutter analyze` dan `flutter test` untuk memverifikasi nol peringatan dan validasi lengkap.
