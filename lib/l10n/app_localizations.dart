import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_jv.dart';
import 'app_localizations_su.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('id'),
    Locale('ja'),
    Locale('jv'),
    Locale('su'),
    Locale('zh'),
  ];

  /// No description provided for @appName.
  ///
  /// In id, this message translates to:
  /// **'RuleBook'**
  String get appName;

  /// No description provided for @appDescription.
  ///
  /// In id, this message translates to:
  /// **'Buku Saku Aturan, Regulasi & Panduan Praktis'**
  String get appDescription;

  /// No description provided for @settings.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan'**
  String get settings;

  /// No description provided for @appearance.
  ///
  /// In id, this message translates to:
  /// **'Tampilan'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In id, this message translates to:
  /// **'Tema'**
  String get theme;

  /// No description provided for @language.
  ///
  /// In id, this message translates to:
  /// **'Bahasa'**
  String get language;

  /// No description provided for @themeLight.
  ///
  /// In id, this message translates to:
  /// **'Terang'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In id, this message translates to:
  /// **'Gelap'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In id, this message translates to:
  /// **'Sistem'**
  String get themeSystem;

  /// No description provided for @selectTheme.
  ///
  /// In id, this message translates to:
  /// **'Pilih Tema'**
  String get selectTheme;

  /// No description provided for @selectLanguage.
  ///
  /// In id, this message translates to:
  /// **'Pilih Bahasa'**
  String get selectLanguage;

  /// No description provided for @localeIndonesian.
  ///
  /// In id, this message translates to:
  /// **'Bahasa Indonesia'**
  String get localeIndonesian;

  /// No description provided for @localeEnglish.
  ///
  /// In id, this message translates to:
  /// **'English'**
  String get localeEnglish;

  /// No description provided for @localeArabic.
  ///
  /// In id, this message translates to:
  /// **'العربية'**
  String get localeArabic;

  /// No description provided for @localeJavanese.
  ///
  /// In id, this message translates to:
  /// **'Basa Jawa'**
  String get localeJavanese;

  /// No description provided for @localeSundanese.
  ///
  /// In id, this message translates to:
  /// **'Basa Sunda'**
  String get localeSundanese;

  /// No description provided for @localeChinese.
  ///
  /// In id, this message translates to:
  /// **'中文'**
  String get localeChinese;

  /// No description provided for @localeJapanese.
  ///
  /// In id, this message translates to:
  /// **'日本語'**
  String get localeJapanese;

  /// No description provided for @localeSpanish.
  ///
  /// In id, this message translates to:
  /// **'Español'**
  String get localeSpanish;

  /// No description provided for @about.
  ///
  /// In id, this message translates to:
  /// **'Tentang'**
  String get about;

  /// No description provided for @cancel.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In id, this message translates to:
  /// **'Hapus'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In id, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In id, this message translates to:
  /// **'Tambah'**
  String get add;

  /// No description provided for @search.
  ///
  /// In id, this message translates to:
  /// **'Cari Aturan & Regulasi...'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In id, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @reset.
  ///
  /// In id, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @confirm.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi'**
  String get confirm;

  /// No description provided for @yes.
  ///
  /// In id, this message translates to:
  /// **'Ya'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In id, this message translates to:
  /// **'Tidak'**
  String get no;

  /// No description provided for @close.
  ///
  /// In id, this message translates to:
  /// **'Tutup'**
  String get close;

  /// No description provided for @navCatalog.
  ///
  /// In id, this message translates to:
  /// **'Katalog Aturan'**
  String get navCatalog;

  /// No description provided for @navCalculator.
  ///
  /// In id, this message translates to:
  /// **'Kalkulator Denda'**
  String get navCalculator;

  /// No description provided for @navSop.
  ///
  /// In id, this message translates to:
  /// **'SOP Tanggap'**
  String get navSop;

  /// No description provided for @navChecklist.
  ///
  /// In id, this message translates to:
  /// **'Audit Kepatuhan'**
  String get navChecklist;

  /// No description provided for @navBookmarks.
  ///
  /// In id, this message translates to:
  /// **'Simpanan'**
  String get navBookmarks;

  /// No description provided for @navSettings.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan'**
  String get navSettings;

  /// No description provided for @catalogTitle.
  ///
  /// In id, this message translates to:
  /// **'Katalog Regulasi & Panduan Praktis'**
  String get catalogTitle;

  /// No description provided for @allCategories.
  ///
  /// In id, this message translates to:
  /// **'Semua Kategori'**
  String get allCategories;

  /// No description provided for @catTraffic.
  ///
  /// In id, this message translates to:
  /// **'Lalu Lintas & Jalan Raya'**
  String get catTraffic;

  /// No description provided for @catLabor.
  ///
  /// In id, this message translates to:
  /// **'Ketenagakerjaan & Karyawan'**
  String get catLabor;

  /// No description provided for @catConsumer.
  ///
  /// In id, this message translates to:
  /// **'Perlindungan Konsumen'**
  String get catConsumer;

  /// No description provided for @catCyber.
  ///
  /// In id, this message translates to:
  /// **'Hukum Siber & ITE'**
  String get catCyber;

  /// No description provided for @catHousing.
  ///
  /// In id, this message translates to:
  /// **'Perumahan & Pertanahan'**
  String get catHousing;

  /// No description provided for @catCivil.
  ///
  /// In id, this message translates to:
  /// **'Perdata & Keluarga'**
  String get catCivil;

  /// No description provided for @catCriminal.
  ///
  /// In id, this message translates to:
  /// **'Pidana Umum'**
  String get catCriminal;

  /// No description provided for @ruleNumber.
  ///
  /// In id, this message translates to:
  /// **'Pasal & Regulasi'**
  String get ruleNumber;

  /// No description provided for @summary.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan Intisari'**
  String get summary;

  /// No description provided for @legalBasis.
  ///
  /// In id, this message translates to:
  /// **'Dasar Hukum Resmi'**
  String get legalBasis;

  /// No description provided for @penalties.
  ///
  /// In id, this message translates to:
  /// **'Sanksi Pidana & Denda'**
  String get penalties;

  /// No description provided for @rights.
  ///
  /// In id, this message translates to:
  /// **'Hak Hukum Wajib Anda Ketahui'**
  String get rights;

  /// No description provided for @noRulesFound.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada aturan yang sesuai dengan kata kunci'**
  String get noRulesFound;

  /// No description provided for @calculatorTitle.
  ///
  /// In id, this message translates to:
  /// **'Kalkulator Sanksi & Hak Pesangon'**
  String get calculatorTitle;

  /// No description provided for @simulasiDenda.
  ///
  /// In id, this message translates to:
  /// **'Simulasi Denda Tilang (UU LLAJ)'**
  String get simulasiDenda;

  /// No description provided for @selectViolation.
  ///
  /// In id, this message translates to:
  /// **'Pilih Jenis Pelanggaran'**
  String get selectViolation;

  /// No description provided for @maximumFine.
  ///
  /// In id, this message translates to:
  /// **'Denda Maksimal Resmi'**
  String get maximumFine;

  /// No description provided for @imprisonment.
  ///
  /// In id, this message translates to:
  /// **'Kurungan Maksimal'**
  String get imprisonment;

  /// No description provided for @severanceTitle.
  ///
  /// In id, this message translates to:
  /// **'Kalkulator Uang Pesangon (UU Cipta Kerja)'**
  String get severanceTitle;

  /// No description provided for @yearsOfService.
  ///
  /// In id, this message translates to:
  /// **'Masa Kerja (Tahun)'**
  String get yearsOfService;

  /// No description provided for @monthlySalary.
  ///
  /// In id, this message translates to:
  /// **'Gaji Pokok + Tunjangan Tetap (Rp)'**
  String get monthlySalary;

  /// No description provided for @terminationReason.
  ///
  /// In id, this message translates to:
  /// **'Alasan Pemutusan Hubungan Kerja (PHK)'**
  String get terminationReason;

  /// No description provided for @calculatedSeverance.
  ///
  /// In id, this message translates to:
  /// **'Total Hak Pesangon & UPMK'**
  String get calculatedSeverance;

  /// No description provided for @sopTitle.
  ///
  /// In id, this message translates to:
  /// **'SOP Tindakan Darurat & Prosedur'**
  String get sopTitle;

  /// No description provided for @emergencySteps.
  ///
  /// In id, this message translates to:
  /// **'Langkah Demi Langkah Tindakan Darurat'**
  String get emergencySteps;

  /// No description provided for @hotlineContacts.
  ///
  /// In id, this message translates to:
  /// **'Hotline & Kontak Resmi Terkait'**
  String get hotlineContacts;

  /// No description provided for @stepByStep.
  ///
  /// In id, this message translates to:
  /// **'Langkah Prosedur'**
  String get stepByStep;

  /// No description provided for @checklistTitle.
  ///
  /// In id, this message translates to:
  /// **'Audit Kepatuhan Mandiri'**
  String get checklistTitle;

  /// No description provided for @bookmarkTitle.
  ///
  /// In id, this message translates to:
  /// **'Aturan & Catatan Tersimpan'**
  String get bookmarkTitle;

  /// No description provided for @noBookmarks.
  ///
  /// In id, this message translates to:
  /// **'Belum Ada Aturan Tersimpan'**
  String get noBookmarks;

  /// No description provided for @personalNote.
  ///
  /// In id, this message translates to:
  /// **'Catatan pribadi'**
  String get personalNote;

  /// No description provided for @addNote.
  ///
  /// In id, this message translates to:
  /// **'Tambah Catatan'**
  String get addNote;

  /// No description provided for @noteSaved.
  ///
  /// In id, this message translates to:
  /// **'Catatan tersimpan'**
  String get noteSaved;

  /// No description provided for @disclaimerTitle.
  ///
  /// In id, this message translates to:
  /// **'Pernyataan Penyangkalan (Disclaimer)'**
  String get disclaimerTitle;

  /// No description provided for @disclaimerText.
  ///
  /// In id, this message translates to:
  /// **'Aplikasi ini adalah media edukasi dan panduan saku hukum praktis, bukan merupakan nasihat hukum formal atau perwakilan lembaga pemerintah resmi.'**
  String get disclaimerText;

  /// No description provided for @dataManagement.
  ///
  /// In id, this message translates to:
  /// **'Manajemen Data & Catatan'**
  String get dataManagement;

  /// No description provided for @clearBookmarks.
  ///
  /// In id, this message translates to:
  /// **'Hapus Semua Catatan & Bookmark'**
  String get clearBookmarks;

  /// No description provided for @privacyNotice.
  ///
  /// In id, this message translates to:
  /// **'100% Offline & Privat. Tidak ada data pencarian atau catatan yang dikirim ke server luar.'**
  String get privacyNotice;

  /// No description provided for @settingsAndPrivacy.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan & Privasi'**
  String get settingsAndPrivacy;

  /// No description provided for @offlineAndPrivate.
  ///
  /// In id, this message translates to:
  /// **'100% Offline & Privat'**
  String get offlineAndPrivate;

  /// No description provided for @offlineNoticeDetail.
  ///
  /// In id, this message translates to:
  /// **'Seluruh aturan hukum, SOP darurat, checklist audit, dan catatan pribadi tersimpan aman di perangkat lokal Anda tanpa pengiriman data ke server luar.'**
  String get offlineNoticeDetail;

  /// No description provided for @deleteNotesBookmarksDesc.
  ///
  /// In id, this message translates to:
  /// **'Mengosongkan semua simpanan dan catatan lokal'**
  String get deleteNotesBookmarksDesc;

  /// No description provided for @deleteAllDataConfirm.
  ///
  /// In id, this message translates to:
  /// **'Hapus Semua Data?'**
  String get deleteAllDataConfirm;

  /// No description provided for @deleteAllDataDesc.
  ///
  /// In id, this message translates to:
  /// **'Tindakan ini akan menghapus semua bookmark dan catatan aturan yang Anda buat.'**
  String get deleteAllDataDesc;

  /// No description provided for @allBookmarksCleared.
  ///
  /// In id, this message translates to:
  /// **'Semua data bookmark dan catatan telah dibersihkan.'**
  String get allBookmarksCleared;

  /// No description provided for @aboutApplication.
  ///
  /// In id, this message translates to:
  /// **'Tentang Aplikasi'**
  String get aboutApplication;

  /// No description provided for @application.
  ///
  /// In id, this message translates to:
  /// **'Aplikasi'**
  String get application;

  /// No description provided for @version.
  ///
  /// In id, this message translates to:
  /// **'Versi'**
  String get version;

  /// No description provided for @ecosystem.
  ///
  /// In id, this message translates to:
  /// **'Ekosistem'**
  String get ecosystem;

  /// No description provided for @subdomain.
  ///
  /// In id, this message translates to:
  /// **'Subdomain'**
  String get subdomain;

  /// No description provided for @applicationId.
  ///
  /// In id, this message translates to:
  /// **'Application ID'**
  String get applicationId;

  /// No description provided for @simulationAndCalculator.
  ///
  /// In id, this message translates to:
  /// **'Simulasi & Kalkulator'**
  String get simulationAndCalculator;

  /// No description provided for @tabOvertimePay.
  ///
  /// In id, this message translates to:
  /// **'Upah Lembur'**
  String get tabOvertimePay;

  /// No description provided for @tabSeverancePay.
  ///
  /// In id, this message translates to:
  /// **'Pesangon PHK'**
  String get tabSeverancePay;

  /// No description provided for @tabProratedThr.
  ///
  /// In id, this message translates to:
  /// **'THR Prorata'**
  String get tabProratedThr;

  /// No description provided for @tabTrafficFine.
  ///
  /// In id, this message translates to:
  /// **'Denda Tilang'**
  String get tabTrafficFine;

  /// No description provided for @tabCyberIteSanctions.
  ///
  /// In id, this message translates to:
  /// **'Sanksi Siber ITE'**
  String get tabCyberIteSanctions;

  /// No description provided for @tenureMinMonthError.
  ///
  /// In id, this message translates to:
  /// **'Masa kerja harus berupa angka minimal 1 bulan'**
  String get tenureMinMonthError;

  /// No description provided for @tenureMaxMonthError.
  ///
  /// In id, this message translates to:
  /// **'Masa kerja maksimal 600 bulan'**
  String get tenureMaxMonthError;

  /// No description provided for @overtimeLegalBasis.
  ///
  /// In id, this message translates to:
  /// **'Dasar Hukum: PP No. 35 Tahun 2021 Pasal 26–31. Upah sejam dihitung 1/173 x Upah Bulanan (Gaji Pokok + Tunjangan Tetap).'**
  String get overtimeLegalBasis;

  /// No description provided for @monthlyBasicSalaryRp.
  ///
  /// In id, this message translates to:
  /// **'Gaji Pokok Bulanan (Rp)'**
  String get monthlyBasicSalaryRp;

  /// No description provided for @totalOvertimeHours.
  ///
  /// In id, this message translates to:
  /// **'Total Jam Lembur'**
  String get totalOvertimeHours;

  /// No description provided for @exampleOvertimeHours.
  ///
  /// In id, this message translates to:
  /// **'Misal: 3'**
  String get exampleOvertimeHours;

  /// No description provided for @overtimeHolidayTitle.
  ///
  /// In id, this message translates to:
  /// **'Lembur di Hari Libur Resmi / Istirahat Mingguan'**
  String get overtimeHolidayTitle;

  /// No description provided for @overtimeHolidayDesc.
  ///
  /// In id, this message translates to:
  /// **'Pengali 2x untuk 8 jam pertama, 3x jam ke-9, 4x jam ke-10+'**
  String get overtimeHolidayDesc;

  /// No description provided for @estimatedOvertimePay.
  ///
  /// In id, this message translates to:
  /// **'Estimasi Upah Lembur Wajib Dibayar'**
  String get estimatedOvertimePay;

  /// No description provided for @overtimeRateHoliday.
  ///
  /// In id, this message translates to:
  /// **'Tarif lembur hari libur resmi (PP 35/2021)'**
  String get overtimeRateHoliday;

  /// No description provided for @overtimeRateRegular.
  ///
  /// In id, this message translates to:
  /// **'Tarif lembur hari kerja biasa (1.5x jam 1, 2x jam berikutnya)'**
  String get overtimeRateRegular;

  /// No description provided for @hourlyWage.
  ///
  /// In id, this message translates to:
  /// **'Upah per Jam (1/173)'**
  String get hourlyWage;

  /// No description provided for @totalHoursLabel.
  ///
  /// In id, this message translates to:
  /// **'Total Jam'**
  String get totalHoursLabel;

  /// No description provided for @hoursUnit.
  ///
  /// In id, this message translates to:
  /// **'Jam'**
  String get hoursUnit;

  /// No description provided for @overtimeCopiedSuccess.
  ///
  /// In id, this message translates to:
  /// **'Hasil lembur berhasil disalin ke clipboard!'**
  String get overtimeCopiedSuccess;

  /// No description provided for @severanceLegalBasis.
  ///
  /// In id, this message translates to:
  /// **'Kalkulator Pesangon Resmi sesuai PP No. 35/2021 jo. UU Cipta Kerja No. 6/2023. Menghitung Uang Pesangon (UP), Penghargaan Masa Kerja (UPMK), & Penggantian Hak (UPH).'**
  String get severanceLegalBasis;

  /// No description provided for @basicSalaryFixedAllowance.
  ///
  /// In id, this message translates to:
  /// **'Gaji Pokok + Tunjangan Tetap (Rp)'**
  String get basicSalaryFixedAllowance;

  /// No description provided for @serviceExtraMonths.
  ///
  /// In id, this message translates to:
  /// **'Lebihan (Bulan)'**
  String get serviceExtraMonths;

  /// No description provided for @uphCompensation.
  ///
  /// In id, this message translates to:
  /// **'Uang Penggantian Hak / UPH (Cuti belum gugur/ongkos)'**
  String get uphCompensation;

  /// No description provided for @totalSeverancePayTitle.
  ///
  /// In id, this message translates to:
  /// **'Total Hak Kompensasi PHK Wajib Diterima'**
  String get totalSeverancePayTitle;

  /// No description provided for @severancePayLabel.
  ///
  /// In id, this message translates to:
  /// **'Uang Pesangon'**
  String get severancePayLabel;

  /// No description provided for @upmkPayLabel.
  ///
  /// In id, this message translates to:
  /// **'Uang Penghargaan Masa Kerja'**
  String get upmkPayLabel;

  /// No description provided for @severanceCopiedSuccess.
  ///
  /// In id, this message translates to:
  /// **'Rincian pesangon berhasil disalin ke clipboard!'**
  String get severanceCopiedSuccess;

  /// No description provided for @thrLegalBasis.
  ///
  /// In id, this message translates to:
  /// **'Dasar Hukum: Permenaker No. 6/2016 jo. PP 36/2021. Masa kerja >= 12 bulan = 1 bulan upah penuh. Masa kerja 1 s.d. 12 bulan dihitung proporsional (prorata).'**
  String get thrLegalBasis;

  /// No description provided for @monthlyNetWage.
  ///
  /// In id, this message translates to:
  /// **'Upah Bulanan Bersih (Gaji Pokok + Tunjangan Tetap)'**
  String get monthlyNetWage;

  /// No description provided for @continuousServiceMonths.
  ///
  /// In id, this message translates to:
  /// **'Masa Kerja Terus Menerus (Bulan)'**
  String get continuousServiceMonths;

  /// No description provided for @exampleEightMonths.
  ///
  /// In id, this message translates to:
  /// **'Misal: 8 bulan'**
  String get exampleEightMonths;

  /// No description provided for @estimatedThrTitle.
  ///
  /// In id, this message translates to:
  /// **'Estimasi Hak Tunjangan Hari Raya (THR)'**
  String get estimatedThrTitle;

  /// No description provided for @thrRuleFull.
  ///
  /// In id, this message translates to:
  /// **'Masa kerja >= 12 bulan: 1 Bulan Upah Penuh'**
  String get thrRuleFull;

  /// No description provided for @thrRuleProrate.
  ///
  /// In id, this message translates to:
  /// **'Masa kerja di bawah 12 bulan: dihitung proporsional (masa kerja / 12 × upah)'**
  String get thrRuleProrate;

  /// No description provided for @thrMonthsNeeded.
  ///
  /// In id, this message translates to:
  /// **'Isi masa kerja Anda, minimal 1 bulan'**
  String get thrMonthsNeeded;

  /// No description provided for @thrDeadlineDetail.
  ///
  /// In id, this message translates to:
  /// **'Batas akhir pembayaran: H-7 hari raya'**
  String get thrDeadlineDetail;

  /// No description provided for @thrCashOnlyDetail.
  ///
  /// In id, this message translates to:
  /// **'Wajib dibayar dalam bentuk uang, bukan barang'**
  String get thrCashOnlyDetail;

  /// No description provided for @thrLatePenalty.
  ///
  /// In id, this message translates to:
  /// **'Jika telat: denda 5% dari total THR bagi pengusaha'**
  String get thrLatePenalty;

  /// No description provided for @thrCopiedSuccess.
  ///
  /// In id, this message translates to:
  /// **'Perhitungan THR berhasil disalin!'**
  String get thrCopiedSuccess;

  /// No description provided for @trafficLegalBasis.
  ///
  /// In id, this message translates to:
  /// **'Dasar Hukum: UU No. 22 Tahun 2009 tentang Lalu Lintas dan Angkutan Jalan. Nilai denda berikut adalah batas maksimal denda tilang pidana pengadilan.'**
  String get trafficLegalBasis;

  /// No description provided for @totalEstimatedMaxFine.
  ///
  /// In id, this message translates to:
  /// **'Total Estimasi Denda Maksimal'**
  String get totalEstimatedMaxFine;

  /// No description provided for @resetSelection.
  ///
  /// In id, this message translates to:
  /// **'Reset Pilihan'**
  String get resetSelection;

  /// No description provided for @selectViolationsHint.
  ///
  /// In id, this message translates to:
  /// **'Pilih Pelanggaran Terkait untuk Melihat Simulasi Denda:'**
  String get selectViolationsHint;

  /// No description provided for @iteLegalBasis.
  ///
  /// In id, this message translates to:
  /// **'Dasar Hukum: UU ITE No. 1 Tahun 2024 & UU PDP No. 27 Tahun 2022. Membedakan delik aduan absolut (pencemaran) dan delik biasa (penipuan siber/hoaks).'**
  String get iteLegalBasis;

  /// No description provided for @complaintOffenseOnly.
  ///
  /// In id, this message translates to:
  /// **'Hanya Tampilkan Delik Aduan (Korban Langsung)'**
  String get complaintOffenseOnly;

  /// No description provided for @complaintOffense.
  ///
  /// In id, this message translates to:
  /// **'Delik Aduan'**
  String get complaintOffense;

  /// No description provided for @ordinaryOffense.
  ///
  /// In id, this message translates to:
  /// **'Delik Biasa'**
  String get ordinaryOffense;

  /// No description provided for @maxPrison.
  ///
  /// In id, this message translates to:
  /// **'Penjara Maks.'**
  String get maxPrison;

  /// No description provided for @yearsUnit.
  ///
  /// In id, this message translates to:
  /// **'Thn'**
  String get yearsUnit;

  /// No description provided for @maxFine.
  ///
  /// In id, this message translates to:
  /// **'Denda Maks.'**
  String get maxFine;

  /// No description provided for @legalTips.
  ///
  /// In id, this message translates to:
  /// **'Tips Hukum'**
  String get legalTips;

  /// No description provided for @defenseExemption.
  ///
  /// In id, this message translates to:
  /// **'Pengecualian'**
  String get defenseExemption;

  /// No description provided for @copyResults.
  ///
  /// In id, this message translates to:
  /// **'Salin Hasil'**
  String get copyResults;

  /// No description provided for @noteDeleted.
  ///
  /// In id, this message translates to:
  /// **'Catatan dihapus'**
  String get noteDeleted;

  /// No description provided for @saveRule.
  ///
  /// In id, this message translates to:
  /// **'Simpan aturan'**
  String get saveRule;

  /// No description provided for @removeBookmark.
  ///
  /// In id, this message translates to:
  /// **'Hapus dari simpanan'**
  String get removeBookmark;

  /// No description provided for @officialPenaltyOrRight.
  ///
  /// In id, this message translates to:
  /// **'Sanksi / Hak Resmi'**
  String get officialPenaltyOrRight;

  /// No description provided for @summaryExplanation.
  ///
  /// In id, this message translates to:
  /// **'Penjelasan Intisari'**
  String get summaryExplanation;

  /// No description provided for @practicalGuidance.
  ///
  /// In id, this message translates to:
  /// **'Panduan Praktis di Lapangan'**
  String get practicalGuidance;

  /// No description provided for @writeCaseNotesHint.
  ///
  /// In id, this message translates to:
  /// **'Tuliskan catatan kasus, tanggal kejadian, atau pengingat...'**
  String get writeCaseNotesHint;

  /// No description provided for @saveNote.
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get saveNote;

  /// No description provided for @relatedRules.
  ///
  /// In id, this message translates to:
  /// **'Masih satu topik'**
  String get relatedRules;

  /// No description provided for @copySummary.
  ///
  /// In id, this message translates to:
  /// **'Salin ringkasan'**
  String get copySummary;

  /// No description provided for @searchRulesHint.
  ///
  /// In id, this message translates to:
  /// **'Cari aturan, pasal, atau situasi...'**
  String get searchRulesHint;

  /// No description provided for @resetFilter.
  ///
  /// In id, this message translates to:
  /// **'Reset Filter'**
  String get resetFilter;

  /// No description provided for @noRulesMatch.
  ///
  /// In id, this message translates to:
  /// **'Belum ada yang cocok'**
  String get noRulesMatch;

  /// No description provided for @tryOtherKeywords.
  ///
  /// In id, this message translates to:
  /// **'Coba kata kunci lain, atau ganti topiknya.'**
  String get tryOtherKeywords;

  /// No description provided for @sopEmergencyGuide.
  ///
  /// In id, this message translates to:
  /// **'SOP & Panduan Darurat'**
  String get sopEmergencyGuide;

  /// No description provided for @sopBanner.
  ///
  /// In id, this message translates to:
  /// **'Panduan langkah-demi-langkah resmi saat menghadapi situasi kritis: razia tilang, PHK sepihak, barang rusak, kebocoran data, dan kecelakaan kerja.'**
  String get sopBanner;

  /// No description provided for @noSopForCategory.
  ///
  /// In id, this message translates to:
  /// **'Tidak Ada SOP untuk Kategori Ini'**
  String get noSopForCategory;

  /// No description provided for @chooseAllCategoryForSop.
  ///
  /// In id, this message translates to:
  /// **'Pilih kategori \"Semua\" untuk melihat seluruh panduan tindakan darurat.'**
  String get chooseAllCategoryForSop;

  /// Number of steps
  ///
  /// In id, this message translates to:
  /// **'{count} Langkah'**
  String stepsCount(int count);

  /// No description provided for @copySopSummary.
  ///
  /// In id, this message translates to:
  /// **'Salin Ringkasan SOP'**
  String get copySopSummary;

  /// No description provided for @sopSummaryCopied.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan SOP berhasil disalin!'**
  String get sopSummaryCopied;

  /// No description provided for @officialSop.
  ///
  /// In id, this message translates to:
  /// **'SOP RESMI'**
  String get officialSop;

  /// No description provided for @situation.
  ///
  /// In id, this message translates to:
  /// **'Situasi'**
  String get situation;

  /// No description provided for @savedAndNotes.
  ///
  /// In id, this message translates to:
  /// **'Tersimpan & Catatan'**
  String get savedAndNotes;

  /// No description provided for @myNotes.
  ///
  /// In id, this message translates to:
  /// **'Catatan Saya'**
  String get myNotes;

  /// No description provided for @noBookmarksHint.
  ///
  /// In id, this message translates to:
  /// **'Tekan ikon bookmark pada aturan untuk menyimpannya ke daftar akses cepat.'**
  String get noBookmarksHint;

  /// No description provided for @noNotes.
  ///
  /// In id, this message translates to:
  /// **'Belum Ada Catatan Pribadi'**
  String get noNotes;

  /// No description provided for @noNotesHint.
  ///
  /// In id, this message translates to:
  /// **'Buka detail aturan untuk menambahkan catatan kasus atau pengingat penting Anda.'**
  String get noNotesHint;

  /// No description provided for @checklistBanner.
  ///
  /// In id, this message translates to:
  /// **'Alat audit kepatuhan interaktif untuk mengecek kelayakan kendaraan, hak kerja normatif, standar K3 gedung, dan keamanan privasi data.'**
  String get checklistBanner;

  /// No description provided for @noAuditModules.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada modul audit untuk kategori ini.'**
  String get noAuditModules;

  /// No description provided for @itemsFulfilled.
  ///
  /// In id, this message translates to:
  /// **'butir terpenuhi'**
  String get itemsFulfilled;

  /// No description provided for @startAudit.
  ///
  /// In id, this message translates to:
  /// **'Mulai Audit'**
  String get startAudit;

  /// No description provided for @perfectCompliance.
  ///
  /// In id, this message translates to:
  /// **'Kepatuhan Sempurna (100%)'**
  String get perfectCompliance;

  /// No description provided for @goodCompliance.
  ///
  /// In id, this message translates to:
  /// **'Kepatuhan Baik'**
  String get goodCompliance;

  /// No description provided for @moderateCompliance.
  ///
  /// In id, this message translates to:
  /// **'Kepatuhan sedang, perlu perbaikan'**
  String get moderateCompliance;

  /// No description provided for @criticalCompliance.
  ///
  /// In id, this message translates to:
  /// **'Tingkat Kepatuhan Kritis'**
  String get criticalCompliance;

  /// No description provided for @targetLabel.
  ///
  /// In id, this message translates to:
  /// **'Sasaran'**
  String get targetLabel;

  /// No description provided for @checklistItems.
  ///
  /// In id, this message translates to:
  /// **'Daftar Butir Pemeriksaan'**
  String get checklistItems;

  /// No description provided for @crucial.
  ///
  /// In id, this message translates to:
  /// **'KRUSIAL'**
  String get crucial;

  /// No description provided for @resetChecklist.
  ///
  /// In id, this message translates to:
  /// **'Reset Checklist'**
  String get resetChecklist;

  /// No description provided for @resetChecklistTitle.
  ///
  /// In id, this message translates to:
  /// **'Reset Checklist?'**
  String get resetChecklistTitle;

  /// No description provided for @resetChecklistConfirmMsg.
  ///
  /// In id, this message translates to:
  /// **'Tindakan ini akan mengosongkan semua tanda centang pada modul audit ini.'**
  String get resetChecklistConfirmMsg;

  /// No description provided for @navCatalogShort.
  ///
  /// In id, this message translates to:
  /// **'Aturan'**
  String get navCatalogShort;

  /// No description provided for @navSimulationShort.
  ///
  /// In id, this message translates to:
  /// **'Hitung'**
  String get navSimulationShort;

  /// No description provided for @navSopShort.
  ///
  /// In id, this message translates to:
  /// **'Darurat'**
  String get navSopShort;

  /// No description provided for @navComplianceShort.
  ///
  /// In id, this message translates to:
  /// **'Audit'**
  String get navComplianceShort;

  /// No description provided for @categoryAll.
  ///
  /// In id, this message translates to:
  /// **'Semua'**
  String get categoryAll;

  /// No description provided for @catSafety.
  ///
  /// In id, this message translates to:
  /// **'Keselamatan (K3)'**
  String get catSafety;

  /// No description provided for @languageSelection.
  ///
  /// In id, this message translates to:
  /// **'Pilihan Bahasa'**
  String get languageSelection;

  /// No description provided for @exportBackupJson.
  ///
  /// In id, this message translates to:
  /// **'Ekspor Cadangan Data (JSON)'**
  String get exportBackupJson;

  /// No description provided for @copyBookmarkNotesClipboard.
  ///
  /// In id, this message translates to:
  /// **'Salin bookmark dan catatan ke clipboard'**
  String get copyBookmarkNotesClipboard;

  /// No description provided for @backupCopiedSnackbar.
  ///
  /// In id, this message translates to:
  /// **'Cadangan data RuleBook berhasil disalin ke clipboard!'**
  String get backupCopiedSnackbar;

  /// No description provided for @catTrafficShort.
  ///
  /// In id, this message translates to:
  /// **'Lalu Lintas'**
  String get catTrafficShort;

  /// No description provided for @catLaborShort.
  ///
  /// In id, this message translates to:
  /// **'Kerja'**
  String get catLaborShort;

  /// No description provided for @catCyberShort.
  ///
  /// In id, this message translates to:
  /// **'Data & ITE'**
  String get catCyberShort;

  /// No description provided for @catConsumerShort.
  ///
  /// In id, this message translates to:
  /// **'Konsumen'**
  String get catConsumerShort;

  /// No description provided for @catSafetyShort.
  ///
  /// In id, this message translates to:
  /// **'K3'**
  String get catSafetyShort;

  /// No description provided for @catCivilShort.
  ///
  /// In id, this message translates to:
  /// **'Etika'**
  String get catCivilShort;

  /// No description provided for @catAllDesc.
  ///
  /// In id, this message translates to:
  /// **'Semua aturan, panduan, dan SOP dalam satu tempat.'**
  String get catAllDesc;

  /// No description provided for @catTrafficDesc.
  ///
  /// In id, this message translates to:
  /// **'Aturan berkendara, tilang, dan keselamatan jalan.'**
  String get catTrafficDesc;

  /// No description provided for @catLaborDesc.
  ///
  /// In id, this message translates to:
  /// **'Jam kerja, lembur, cuti, dan hak pesangon.'**
  String get catLaborDesc;

  /// No description provided for @catCyberDesc.
  ///
  /// In id, this message translates to:
  /// **'Perlindungan data pribadi dan jejak digital Anda.'**
  String get catCyberDesc;

  /// No description provided for @catConsumerDesc.
  ///
  /// In id, this message translates to:
  /// **'Hak pembeli, garansi, dan cara komplain.'**
  String get catConsumerDesc;

  /// No description provided for @catSafetyDesc.
  ///
  /// In id, this message translates to:
  /// **'Prosedur darurat, APD, dan keselamatan kerja.'**
  String get catSafetyDesc;

  /// No description provided for @catCivilDesc.
  ///
  /// In id, this message translates to:
  /// **'Ketertiban umum dan hidup bersama di ruang publik.'**
  String get catCivilDesc;

  /// No description provided for @forYou.
  ///
  /// In id, this message translates to:
  /// **'Untuk Anda'**
  String get forYou;

  /// No description provided for @browseByTopic.
  ///
  /// In id, this message translates to:
  /// **'Telusuri topik'**
  String get browseByTopic;

  /// No description provided for @searchAriaLabel.
  ///
  /// In id, this message translates to:
  /// **'Kolom pencarian aturan'**
  String get searchAriaLabel;

  /// No description provided for @resultsCount.
  ///
  /// In id, this message translates to:
  /// **'{count} aturan'**
  String resultsCount(Object count);

  /// No description provided for @clearSearch.
  ///
  /// In id, this message translates to:
  /// **'Bersihkan pencarian'**
  String get clearSearch;

  /// No description provided for @resetFilters.
  ///
  /// In id, this message translates to:
  /// **'Atur ulang'**
  String get resetFilters;

  /// No description provided for @readingTime.
  ///
  /// In id, this message translates to:
  /// **'{minutes} mnt baca'**
  String readingTime(Object minutes);

  /// No description provided for @ruleDetailMeta.
  ///
  /// In id, this message translates to:
  /// **'Detail aturan'**
  String get ruleDetailMeta;

  /// No description provided for @whatItMeans.
  ///
  /// In id, this message translates to:
  /// **'Apa artinya untuk Anda'**
  String get whatItMeans;

  /// No description provided for @doThis.
  ///
  /// In id, this message translates to:
  /// **'Lakukan'**
  String get doThis;

  /// No description provided for @avoidThis.
  ///
  /// In id, this message translates to:
  /// **'Hindari'**
  String get avoidThis;

  /// No description provided for @legalBasisLabel.
  ///
  /// In id, this message translates to:
  /// **'Dasar hukum'**
  String get legalBasisLabel;

  /// No description provided for @consequenceLabel.
  ///
  /// In id, this message translates to:
  /// **'Konsekuensi'**
  String get consequenceLabel;

  /// No description provided for @noteEmptyHint.
  ///
  /// In id, this message translates to:
  /// **'Simpan tanggal kejadian, nomor surat, atau hal yang perlu Anda ingat.'**
  String get noteEmptyHint;

  /// No description provided for @summaryCopied.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan disalin'**
  String get summaryCopied;

  /// No description provided for @clearNote.
  ///
  /// In id, this message translates to:
  /// **'Kosongkan'**
  String get clearNote;

  /// No description provided for @noteLengthCounter.
  ///
  /// In id, this message translates to:
  /// **'{count}/{max} karakter'**
  String noteLengthCounter(Object count, Object max);

  /// No description provided for @deleteNoteTitle.
  ///
  /// In id, this message translates to:
  /// **'Hapus catatan ini?'**
  String get deleteNoteTitle;

  /// No description provided for @deleteNoteDesc.
  ///
  /// In id, this message translates to:
  /// **'Catatan yang sudah dihapus tidak bisa dikembalikan. Aturannya tetap ada di katalog.'**
  String get deleteNoteDesc;

  /// No description provided for @licenseLabel.
  ///
  /// In id, this message translates to:
  /// **'Lisensi'**
  String get licenseLabel;

  /// No description provided for @licenseValue.
  ///
  /// In id, this message translates to:
  /// **'Personal & Non-Profit'**
  String get licenseValue;

  /// No description provided for @noAuditModulesTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum ada modul audit di sini'**
  String get noAuditModulesTitle;

  /// No description provided for @noAuditModulesHint.
  ///
  /// In id, this message translates to:
  /// **'Coba kategori lain, atau pilih Semua untuk melihat semua modul.'**
  String get noAuditModulesHint;

  /// No description provided for @itemsFulfilledCount.
  ///
  /// In id, this message translates to:
  /// **'{count}/{max} butir terpenuhi'**
  String itemsFulfilledCount(Object count, Object max);

  /// No description provided for @missingTitle.
  ///
  /// In id, this message translates to:
  /// **'Halaman tidak ditemukan'**
  String get missingTitle;

  /// No description provided for @missingDesc.
  ///
  /// In id, this message translates to:
  /// **'Tautannya mungkin sudah usang. Kembali dan coba lagi.'**
  String get missingDesc;

  /// No description provided for @backToRules.
  ///
  /// In id, this message translates to:
  /// **'Kembali ke aturan'**
  String get backToRules;

  /// Judul seksi pengaturan zona waktu
  ///
  /// In id, this message translates to:
  /// **'Zona Waktu'**
  String get timezone;

  /// Opsi zona waktu otomatis mengikuti perangkat
  ///
  /// In id, this message translates to:
  /// **'Otomatis (ikut perangkat)'**
  String get timezoneAuto;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'en',
    'es',
    'id',
    'ja',
    'jv',
    'su',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'id':
      return AppLocalizationsId();
    case 'ja':
      return AppLocalizationsJa();
    case 'jv':
      return AppLocalizationsJv();
    case 'su':
      return AppLocalizationsSu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
