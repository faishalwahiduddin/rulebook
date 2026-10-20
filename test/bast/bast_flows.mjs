// BAST capture (standards §TRACE, profil Flutter) — jalankan dari akar app: node test/bast/bast_flows.mjs
import { runFlutterBast } from "/Users/rumah/projects/scripts/trace-graph/kit/flutter-web.mjs";

const ID = { "flutter.locale": '"id"' };
const READY = { ...ID, "flutter.onboarding_completed": "true" };

/** Muat ulang app dengan preferensi lokal (bahasa Indonesia, onboarding selesai) dan aktifkan semantics. */
async function boot(page, prefs = READY) {
  await page.evaluate((p) => { localStorage.clear(); for (const [k, v] of Object.entries(p)) localStorage.setItem(k, v); }, prefs);
  await page.goto(new URL(page.url()).origin + "/", { waitUntil: "load" });
  const ph = page.locator("flt-semantics-placeholder");
  await ph.waitFor({ state: "attached", timeout: 30000 }).catch(() => {});
  await ph.dispatchEvent("click").catch(() => {});
  await page.waitForTimeout(2500);
}
const btn = (page, name) => page.getByRole("button", { name }).first();
const card = (page, name) => page.getByRole("group", { name }).first();

/** Fokuskan kolom (locator), tunggu fokus terpasang, ganti isinya. */
async function fill(page, loc, text) {
  await loc.waitFor({ state: "attached", timeout: 15000 });
  const box = await loc.boundingBox();
  await page.mouse.click(box.x + box.width / 2, box.y + box.height / 2);
  await page.waitForTimeout(600);
  await page.keyboard.press("ControlOrMeta+A");
  await page.keyboard.type(text, { delay: 40 });
  await page.waitForTimeout(500);
}
const field = (page, label) => page.getByLabel(label).or(page.getByText(label)).first();

const flows = [
  {
    flow: "FLOW-RUL-01", tc: "FLOW-RUL-01-T01", role: "ROL-001",
    title: "Menelusuri kategori dan membaca butir aturan",
    summary: "Pengguna membuka RuleBook pertama kali, memilih kategori **Lalu Lintas**, lalu membaca ringkasan, dasar hukum, dan sanksi sebuah butir aturan — tanpa internet.",
    async run(page, g) {
      await boot(page, ID);
      await g.step("Buka aplikasi", "Saat pertama dibuka, RuleBook menampilkan layar perkenalan. Ketuk **Lewati** untuk langsung masuk.");
      await g.tap("Lewati", { exact: true });
      await page.waitForTimeout(1200);
      await g.step("Lihat katalog aturan", "Layar **Aturan** menampilkan seluruh butir aturan beserta jumlahnya dan lencana literasi hukum.");
      await g.tap(btn(page, /^Lalu Lintas$/));
      await g.step("Pilih kategori", "Ketuk chip **Lalu Lintas** untuk menyaring daftar hanya ke aturan lalu lintas dan jalan raya.");
      await g.tap(card(page, /Larangan Menggunakan Ponsel/));
      await page.waitForTimeout(800);
      await g.step("Baca butir aturan", "Ketuk kartu **Larangan Menggunakan Ponsel Saat Berkendara**. Detail menampilkan dasar hukum **UU No. 22 Tahun 2009 Pasal 283** dan **Konsekuensi** berupa denda maksimal Rp 750.000.");
      await page.mouse.move(215, 500);
      await page.mouse.wheel(0, 500);
      await page.waitForTimeout(800);
      await g.step("Pahami intisari", "Gulir ke bawah untuk membaca **Apa artinya untuk Anda**, daftar **Lakukan**, dan **Hindari** dalam bahasa sehari-hari.");
    },
  },
  {
    flow: "FLOW-RUL-02", tc: "FLOW-RUL-02-T01", role: "ROL-001",
    title: "Mencari aturan secara instan",
    summary: "Pengguna mengetik kata kunci di kolom pencarian; hasil tersaring seketika dari judul, ringkasan, dasar hukum, dan kata kunci.",
    async run(page, g) {
      await boot(page);
      await g.step("Buka layar Aturan", "Kolom **Cari aturan, pasal, atau situasi...** ada di bagian atas layar **Aturan**.");
      await fill(page, field(page, "Cari aturan, pasal, atau situasi..."), "helm");
      await g.step("Ketik kata kunci", "Ketik **helm**. Daftar langsung tersaring menjadi **2 aturan** yang relevan.");
      await g.tap(btn(page, /^Bersihkan pencarian/));
      await g.step("Bersihkan pencarian", "Ketuk ikon **Bersihkan pencarian** untuk kembali ke seluruh **31 aturan**.");
      await g.tap(btn(page, /^Lembur$/));
      await g.step("Gunakan pencarian cepat", "Ketuk chip **Lembur** di bawah kolom pencarian untuk mencari topik populer tanpa mengetik.");
    },
  },
  {
    flow: "FLOW-RUL-03", tc: "FLOW-RUL-03-T01", role: "ROL-001",
    title: "Membagikan butir aturan",
    summary: "Pengguna membuka butir aturan lalu menyiapkan **Kartu Aturan** untuk dibagikan ke teman, lengkap dengan dasar hukumnya.",
    async run(page, g) {
      await boot(page);
      await g.tap(card(page, /Batas Kecepatan/));
      await page.waitForTimeout(800);
      await g.step("Buka butir aturan", "Ketuk kartu **Batas Kecepatan Jalan Tol & Arteri** pada layar **Aturan**.");
      await g.tap(btn(page, /^Bagikan Kartu Aturan/));
      await page.waitForTimeout(800);
      await g.step("Siapkan kartu aturan", "Ketuk **Bagikan Kartu Aturan**. Pilih rasio (**4:5 Feed** / **9:16 Story**) dan tema kartu; pratinjau memuat judul, sanksi, dan dasar hukum.");
      await g.tap("9:16 Story");
      await g.step("Kirim atau salin", "Ketuk **Simpan Gambar** untuk menyimpan/membagikan kartu, atau **Salin Teks** untuk menempel ringkasan beserta dasar hukumnya di chat.");
    },
  },
  {
    flow: "FLOW-BKM-01", tc: "FLOW-BKM-01-T01", role: "ROL-001",
    title: "Menyimpan aturan dan catatan pribadi",
    summary: "Pengguna menandai butir aturan penting, menambahkan catatan pribadi, lalu membukanya kembali dari tab **Simpanan** tanpa mencari ulang.",
    async run(page, g) {
      await boot(page);
      await g.tap(card(page, /Kewajiban Membawa SIM/));
      await page.waitForTimeout(800);
      await g.step("Buka butir aturan", "Ketuk kartu **Kewajiban Membawa SIM & STNK Asli**.");
      await g.tap(page.getByRole("button", { name: /Simpan aturan/ }).first());
      await g.step("Simpan aturan", "Ketuk ikon penanda **Simpan aturan** di kanan atas. Ikon berubah terisi tanda aturan tersimpan.");
      await page.mouse.move(215, 500);
      await page.mouse.wheel(0, 600);
      await page.waitForTimeout(800);
      await fill(page, field(page, "Simpan tanggal kejadian, nomor surat, atau hal yang perlu Anda ingat."), "Perpanjang SIM C bulan Desember");
      await g.step("Tulis catatan pribadi", "Pada bagian **Catatan Pribadi**, ketik pengingat Anda (maksimal 500 karakter).");
      await g.tap("Simpan", { exact: true });
      await g.step("Simpan catatan", "Ketuk **Simpan**. Catatan tersimpan di perangkat dan muncul konfirmasi **Catatan tersimpan**.");
      await g.tap(btn(page, /^Kembali$/));
      await page.waitForTimeout(4000); // snackbar menutupi bilah navigasi sampai hilang
      await g.tap(btn(page, /^Simpanan/));
      await page.waitForTimeout(800);
      await g.step("Buka tab Simpanan", "Ketuk tab **Simpanan**. Aturan yang ditandai dan catatan Anda tersedia di sini, termasuk saat offline.");
    },
  },
  {
    flow: "FLOW-CAL-01", tc: "FLOW-CAL-01-T01", role: "ROL-001",
    title: "Menghitung estimasi upah lembur",
    summary: "Pengguna membuka tab **Hitung**, mengisi gaji pokok dan jam lembur, lalu membaca estimasi upah lembur sesuai PP 35/2021.",
    async run(page, g) {
      await boot(page);
      await g.tap(btn(page, /^Hitung/));
      await g.step("Buka kalkulator", "Ketuk tab **Hitung**. Tab **Upah Lembur** terbuka dengan dasar hukum **PP No. 35 Tahun 2021**.");
      await fill(page, page.getByRole("textbox").nth(0), "7500000");
      await fill(page, page.getByRole("textbox").nth(1), "4");
      await g.step("Isi gaji dan jam lembur", "Isi **Gaji Pokok Bulanan (Rp)** dan **Total Jam Lembur**. Estimasi dihitung otomatis: upah per jam = 1/173 gaji bulanan.");
      await g.tap(page.getByRole("switch").first());
      await g.step("Lembur di hari libur", "Aktifkan **Lembur di Hari Libur Resmi / Istirahat Mingguan** untuk memakai pengali 2x, 3x, dan 4x.");
      await g.tap(btn(page, /^Pesangon PHK/));
      await g.step("Pindah ke pesangon", "Ketuk **Pesangon PHK** untuk menghitung pesangon dan UPMK berdasarkan masa kerja dan alasan PHK.");
    },
  },
  {
    flow: "FLOW-SOP-01", tc: "FLOW-SOP-01-T01", role: "ROL-001",
    title: "Membuka SOP darurat",
    summary: "Pengguna dalam situasi darurat membuka tab **Darurat** dan mengikuti langkah SOP beserta dasar hukumnya.",
    async run(page, g) {
      await boot(page);
      await g.tap(btn(page, /^Darurat/));
      await g.step("Buka tab Darurat", "Ketuk tab **Darurat**. Daftar SOP menampilkan skenario dan jumlah langkahnya.");
      await g.tap(btn(page, /Razia & Tilang/));
      await page.waitForTimeout(1000);
      await g.step("Ikuti langkah SOP", "Ketuk **SOP Menghadapi Razia & Tilang Polisi**. Ikuti langkah bernomor dari atas ke bawah.");
    },
  },
  {
    flow: "FLOW-AUD-01", tc: "FLOW-AUD-01-T01", role: "ROL-001",
    title: "Menjalankan audit kepatuhan",
    summary: "Pengguna mencentang butir audit kelaikan berkendara; progres kepatuhan tersimpan di perangkat dan bisa direset.",
    async run(page, g) {
      await boot(page);
      await g.tap(btn(page, /^Audit/));
      await g.step("Buka tab Audit", "Ketuk tab **Audit**. Setiap modul audit menampilkan persentase butir yang sudah terpenuhi.");
      await g.tap(page.getByRole("progressbar", { name: /Kelaikan Berkendara/ }).first());
      await page.waitForTimeout(800);
      await g.step("Buka modul audit", "Ketuk **Audit Kelaikan Berkendara & Dokumen Legalitas**. Butir **KRUSIAL** ditandai khusus.");
      await g.tap(card(page, /Masa Berlaku SIM/));
      await g.tap(card(page, /STNK Asli/));
      await g.step("Centang butir terpenuhi", "Ketuk **Masa Berlaku SIM Masih Aktif** dan **STNK Asli & Pajak Tahunan Sah**. Bilah **Tingkat Kepatuhan** naik otomatis.");
    },
  },
  {
    flow: "FLOW-SET-01", tc: "FLOW-SET-01-T01", role: "ROL-001",
    title: "Mengatur bahasa, tema, dan cadangan data",
    summary: "Pengguna membuka **Pengaturan & Privasi** untuk memilih tema, bahasa, zona waktu, serta mengekspor atau memulihkan cadangan `.rlb`.",
    async run(page, g) {
      await boot(page);
      await g.tap(btn(page, /^Pengaturan & Privasi/));
      await page.waitForTimeout(800);
      await g.step("Buka pengaturan", "Ketuk ikon **Pengaturan & Privasi** di kanan atas layar **Aturan**.");
      await g.tap(btn(page, /^Gelap$/));
      await g.step("Pilih tema", "Pada **Tema**, ketuk **Gelap** untuk mode gelap. Pilihan tersimpan otomatis.");
      await page.mouse.move(215, 500);
      await page.mouse.wheel(0, 500);
      await page.waitForTimeout(800);
      await g.step("Kelola data", "Pada **Manajemen Data & Catatan** pilih **Ekspor cadangan (.rlb)**, **Pulihkan dari berkas (.rlb)**, atau **Hapus Semua Catatan & Bookmark**. **Pernyataan Penyangkalan** menegaskan isi app bukan nasihat hukum.");
    },
  },
];

// BAST_NO_BUILD=1 memakai build/web yang sudah ada; BAST_ONLY=FLOW-A,FLOW-B merekam ulang sebagian flow.
const only = process.env.BAST_ONLY?.split(",");
await runFlutterBast(import.meta.dirname + "/../..", flows.filter((f) => !only || only.includes(f.flow)), { build: !process.env.BAST_NO_BUILD });
