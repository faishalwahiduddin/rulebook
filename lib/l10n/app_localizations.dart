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
  /// **'Ekspor cadangan (.rlb)'**
  String get exportBackupJson;

  /// No description provided for @copyBookmarkNotesClipboard.
  ///
  /// In id, this message translates to:
  /// **'Bagikan bookmark dan catatan sebagai berkas .rlb'**
  String get copyBookmarkNotesClipboard;

  /// No description provided for @backupCopiedSnackbar.
  ///
  /// In id, this message translates to:
  /// **'Berkas cadangan siap dibagikan'**
  String get backupCopiedSnackbar;

  /// No description provided for @importBackupTitle.
  ///
  /// In id, this message translates to:
  /// **'Pulihkan dari berkas (.rlb)'**
  String get importBackupTitle;

  /// No description provided for @importBackupSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Pilih berkas .rlb — mengganti data lokal'**
  String get importBackupSubtitle;

  /// No description provided for @importBackupSuccess.
  ///
  /// In id, this message translates to:
  /// **'Cadangan berhasil dipulihkan'**
  String get importBackupSuccess;

  /// No description provided for @importBackupFailed.
  ///
  /// In id, this message translates to:
  /// **'Gagal mengimpor: berkas cadangan tidak valid.'**
  String get importBackupFailed;

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

  /// No description provided for @errorSearchQueryTooLong.
  ///
  /// In id, this message translates to:
  /// **'Kata kunci maksimal 64 karakter'**
  String get errorSearchQueryTooLong;

  /// No description provided for @errorNoteEmpty.
  ///
  /// In id, this message translates to:
  /// **'Catatan tidak boleh kosong'**
  String get errorNoteEmpty;

  /// No description provided for @errorNoteTooLong.
  ///
  /// In id, this message translates to:
  /// **'Catatan maksimal 500 karakter'**
  String get errorNoteTooLong;

  /// No description provided for @errorRuleIdInvalid.
  ///
  /// In id, this message translates to:
  /// **'ID aturan tidak valid'**
  String get errorRuleIdInvalid;

  /// No description provided for @errorSalaryRequired.
  ///
  /// In id, this message translates to:
  /// **'Gaji pokok bulanan wajib diisi'**
  String get errorSalaryRequired;

  /// No description provided for @errorSalaryInvalid.
  ///
  /// In id, this message translates to:
  /// **'Nominal gaji harus berupa angka valid'**
  String get errorSalaryInvalid;

  /// No description provided for @errorSalaryMin.
  ///
  /// In id, this message translates to:
  /// **'Gaji pokok minimal Rp 100.000'**
  String get errorSalaryMin;

  /// No description provided for @errorSalaryMax.
  ///
  /// In id, this message translates to:
  /// **'Gaji pokok melebihi batas wajar simulasi (maksimal Rp 1 Miliar)'**
  String get errorSalaryMax;

  /// No description provided for @errorOvertimeHoursRequired.
  ///
  /// In id, this message translates to:
  /// **'Total jam lembur wajib diisi'**
  String get errorOvertimeHoursRequired;

  /// No description provided for @errorOvertimeHoursInvalid.
  ///
  /// In id, this message translates to:
  /// **'Jam lembur harus berupa angka numerik'**
  String get errorOvertimeHoursInvalid;

  /// No description provided for @errorOvertimeHoursMin.
  ///
  /// In id, this message translates to:
  /// **'Jam lembur harus lebih besar dari 0'**
  String get errorOvertimeHoursMin;

  /// No description provided for @errorOvertimeHoursMax.
  ///
  /// In id, this message translates to:
  /// **'Jam lembur maksimal 100 jam per periode hitung'**
  String get errorOvertimeHoursMax;

  /// No description provided for @errorTenureYearsRequired.
  ///
  /// In id, this message translates to:
  /// **'Masa kerja (tahun) wajib diisi'**
  String get errorTenureYearsRequired;

  /// No description provided for @errorTenureYearsInvalid.
  ///
  /// In id, this message translates to:
  /// **'Tahun masa kerja harus berupa bilangan bulat'**
  String get errorTenureYearsInvalid;

  /// No description provided for @errorTenureYearsMin.
  ///
  /// In id, this message translates to:
  /// **'Tahun masa kerja tidak boleh negatif'**
  String get errorTenureYearsMin;

  /// No description provided for @errorTenureYearsMax.
  ///
  /// In id, this message translates to:
  /// **'Tahun masa kerja maksimal 60 tahun'**
  String get errorTenureYearsMax;

  /// No description provided for @errorTenureMonthsInvalid.
  ///
  /// In id, this message translates to:
  /// **'Bulan masa kerja harus berupa bilangan bulat'**
  String get errorTenureMonthsInvalid;

  /// No description provided for @errorTenureMonthsRange.
  ///
  /// In id, this message translates to:
  /// **'Bulan masa kerja harus antara 0 dan 11 bulan'**
  String get errorTenureMonthsRange;

  /// No description provided for @ruleTraffic01Title.
  ///
  /// In id, this message translates to:
  /// **'Batas Kecepatan Jalan Tol & Arteri'**
  String get ruleTraffic01Title;

  /// No description provided for @ruleTraffic01Summary.
  ///
  /// In id, this message translates to:
  /// **'Kecepatan maksimal 100 km/jam di jalan tol luar kota dan minimal 60 km/jam.'**
  String get ruleTraffic01Summary;

  /// No description provided for @ruleTraffic01Penalty.
  ///
  /// In id, this message translates to:
  /// **'Denda maksimal Rp 500.000 atau pidana kurungan paling lama 2 bulan'**
  String get ruleTraffic01Penalty;

  /// No description provided for @ruleTraffic01Explanation.
  ///
  /// In id, this message translates to:
  /// **'Setiap pengemudi wajib mematuhi rambu batas kecepatan. Di jalan tol luar kota batas maksimal adalah 100 km/jam dan minimal 60 km/jam. Di jalan tol dalam kota maksimal 80 km/jam. Di jalan antarkota maksimal 80 km/jam, kawasan perkotaan 50 km/jam, dan kawasan permukiman 30 km/jam.'**
  String get ruleTraffic01Explanation;

  /// No description provided for @ruleTraffic01Dos.
  ///
  /// In id, this message translates to:
  /// **'Perhatikan rambu batas kecepatan di setiap ruas jalan\nJaga jarak aman antar kendaraan sesuai kecepatan (aturan 3 detik)'**
  String get ruleTraffic01Dos;

  /// No description provided for @ruleTraffic01Donts.
  ///
  /// In id, this message translates to:
  /// **'Memacu kendaraan di atas 100 km/jam di jalan tol\nBerjalan lambat di lajur paling kanan (lajur hanya untuk mendahului)'**
  String get ruleTraffic01Donts;

  /// No description provided for @ruleTraffic02Title.
  ///
  /// In id, this message translates to:
  /// **'Larangan Menggunakan Ponsel Saat Berkendara'**
  String get ruleTraffic02Title;

  /// No description provided for @ruleTraffic02Summary.
  ///
  /// In id, this message translates to:
  /// **'Dilarang mengoperasikan gawai atau melakukan kegiatan yang mengganggu konsentrasi saat mengemudi.'**
  String get ruleTraffic02Summary;

  /// No description provided for @ruleTraffic02Penalty.
  ///
  /// In id, this message translates to:
  /// **'Denda maksimal Rp 750.000 atau kurungan paling lama 3 bulan'**
  String get ruleTraffic02Penalty;

  /// No description provided for @ruleTraffic02Explanation.
  ///
  /// In id, this message translates to:
  /// **'Pengemudi dilarang melakukan kegiatan yang mengakibatkan gangguan konsentrasi, termasuk mengetik pesan, melihat video, atau memegang telepon saat kendaraan bergerak.'**
  String get ruleTraffic02Explanation;

  /// No description provided for @ruleTraffic02Dos.
  ///
  /// In id, this message translates to:
  /// **'Gunakan holder GPS di dashboard dan atur rute sebelum mulai berjalan\nTepikan kendaraan di tempat aman jika harus menerima telepon darurat'**
  String get ruleTraffic02Dos;

  /// No description provided for @ruleTraffic02Donts.
  ///
  /// In id, this message translates to:
  /// **'Membalas chat atau scrolling media sosial saat berhenti di lampu merah\nMenempelkan ponsel di telinga saat mengemudi'**
  String get ruleTraffic02Donts;

  /// No description provided for @ruleTraffic03Title.
  ///
  /// In id, this message translates to:
  /// **'Kewajiban Membawa SIM & STNK Asli'**
  String get ruleTraffic03Title;

  /// No description provided for @ruleTraffic03Summary.
  ///
  /// In id, this message translates to:
  /// **'Pengendara wajib memiliki SIM sah dan dapat menunjukkan STNK yang sah saat pemeriksaan.'**
  String get ruleTraffic03Summary;

  /// No description provided for @ruleTraffic03Penalty.
  ///
  /// In id, this message translates to:
  /// **'Tidak punya SIM: denda maks Rp 1.000.000; Tidak bawa STNK: denda maks Rp 500.000'**
  String get ruleTraffic03Penalty;

  /// No description provided for @ruleTraffic03Explanation.
  ///
  /// In id, this message translates to:
  /// **'Setiap orang yang mengemudikan kendaraan bermotor di jalan wajib memiliki SIM yang masih berlaku sesuai jenis kendaraannya dan membawa STNK asli yang sah.'**
  String get ruleTraffic03Explanation;

  /// No description provided for @ruleTraffic03Dos.
  ///
  /// In id, this message translates to:
  /// **'Periksa masa berlaku SIM dan pajak tahunan STNK secara berkala\nBawa dokumen fisik atau tunjukkan dokumen digital resmi terintegrasi (Korlantas)'**
  String get ruleTraffic03Dos;

  /// No description provided for @ruleTraffic03Donts.
  ///
  /// In id, this message translates to:
  /// **'Mengemudi tanpa mengantongi SIM yang sah\nMeminjamkan kendaraan ke pengemudi di bawah umur / tanpa SIM'**
  String get ruleTraffic03Donts;

  /// No description provided for @ruleTraffic04Title.
  ///
  /// In id, this message translates to:
  /// **'Lampu Utama Sepeda Motor Siang Hari (DRL)'**
  String get ruleTraffic04Title;

  /// No description provided for @ruleTraffic04Summary.
  ///
  /// In id, this message translates to:
  /// **'Pengendara sepeda motor wajib menyalakan lampu utama pada siang dan malam hari.'**
  String get ruleTraffic04Summary;

  /// No description provided for @ruleTraffic04Penalty.
  ///
  /// In id, this message translates to:
  /// **'Denda maksimal Rp 100.000 atau pidana kurungan paling lama 15 hari'**
  String get ruleTraffic04Penalty;

  /// No description provided for @ruleTraffic04Explanation.
  ///
  /// In id, this message translates to:
  /// **'Untuk meningkatkan visibilitas dan mencegah kecelakaan fatal, sepeda motor wajib menyalakan lampu utama di jalan pada siang hari maupun malam hari.'**
  String get ruleTraffic04Explanation;

  /// No description provided for @ruleTraffic04Dos.
  ///
  /// In id, this message translates to:
  /// **'Pastikan lampu dekat (low beam) menyala otomatis saat mesin dihidupkan\nSegera ganti bohlam lampu jika mati'**
  String get ruleTraffic04Dos;

  /// No description provided for @ruleTraffic04Donts.
  ///
  /// In id, this message translates to:
  /// **'Memasang saklar rahasia untuk mematikan lampu di siang hari\nMenggunakan lampu tembak menyilaukan (strobo/silau) yang melanggar standar'**
  String get ruleTraffic04Donts;

  /// No description provided for @ruleTraffic05Title.
  ///
  /// In id, this message translates to:
  /// **'Helm Berstandar Nasional Indonesia (SNI)'**
  String get ruleTraffic05Title;

  /// No description provided for @ruleTraffic05Summary.
  ///
  /// In id, this message translates to:
  /// **'Pengendara sepeda motor dan penumpangnya wajib mengenakan helm yang memenuhi standar SNI.'**
  String get ruleTraffic05Summary;

  /// No description provided for @ruleTraffic05Penalty.
  ///
  /// In id, this message translates to:
  /// **'Denda maksimal Rp 250.000 atau kurungan paling lama 1 bulan'**
  String get ruleTraffic05Penalty;

  /// No description provided for @ruleTraffic05Explanation.
  ///
  /// In id, this message translates to:
  /// **'Setiap orang yang mengemudikan sepeda motor dan penumpang sepeda motor wajib mengenakan helm standar nasional Indonesia (SNI) terkunci dengan tali pengikat dagu yang benar (klik).'**
  String get ruleTraffic05Explanation;

  /// No description provided for @ruleTraffic05Dos.
  ///
  /// In id, this message translates to:
  /// **'Pastikan logo SNI timbul (emboss) pada batok helm\nKaitkan tali helm hingga berbunyi \"klik\" sebelum mulai berkendara'**
  String get ruleTraffic05Dos;

  /// No description provided for @ruleTraffic05Donts.
  ///
  /// In id, this message translates to:
  /// **'Mengenakan helm proyek atau helm sepeda santai untuk mengendarai motor\nMembiarkan tali helm menggantung tanpa dikunci'**
  String get ruleTraffic05Donts;

  /// No description provided for @ruleTraffic06Title.
  ///
  /// In id, this message translates to:
  /// **'Larangan Melawan Arus Lalu Lintas'**
  String get ruleTraffic06Title;

  /// No description provided for @ruleTraffic06Summary.
  ///
  /// In id, this message translates to:
  /// **'Dilarang mengemudikan kendaraan melawan arah arus lalu lintas yang telah ditentukan rambu.'**
  String get ruleTraffic06Summary;

  /// No description provided for @ruleTraffic06Penalty.
  ///
  /// In id, this message translates to:
  /// **'Denda maksimal Rp 500.000 atau kurungan paling lama 2 bulan'**
  String get ruleTraffic06Penalty;

  /// No description provided for @ruleTraffic06Explanation.
  ///
  /// In id, this message translates to:
  /// **'Melawan arus membahayakan keselamatan umum secara ekstrem dan menjadi penyebab fatalitas kecelakaan lalu lintas tertinggi.'**
  String get ruleTraffic06Explanation;

  /// No description provided for @ruleTraffic06Dos.
  ///
  /// In id, this message translates to:
  /// **'Patuhi rambu satu arah (one-way) dan panah petunjuk jalan\nPilih putaran balik resmi meskipun berjarak agak jauh demi keselamatan'**
  String get ruleTraffic06Dos;

  /// No description provided for @ruleTraffic06Donts.
  ///
  /// In id, this message translates to:
  /// **'Melawan arus di jalur sempit, trotoar, atau bahu jalan layang\nMengikuti pengendara lain yang nekat menerobos jalur berlawanan'**
  String get ruleTraffic06Donts;

  /// No description provided for @ruleTraffic07Title.
  ///
  /// In id, this message translates to:
  /// **'Larangan Menerobos Jalur Busway (TransJakarta)'**
  String get ruleTraffic07Title;

  /// No description provided for @ruleTraffic07Summary.
  ///
  /// In id, this message translates to:
  /// **'Kendaraan pribadi dilarang melintasi atau memasuki jalur khusus angkutan umum (Busway).'**
  String get ruleTraffic07Summary;

  /// No description provided for @ruleTraffic07Penalty.
  ///
  /// In id, this message translates to:
  /// **'Denda maksimal tilang Rp 500.000 atau kurungan paling lama 2 bulan'**
  String get ruleTraffic07Penalty;

  /// No description provided for @ruleTraffic07Explanation.
  ///
  /// In id, this message translates to:
  /// **'Jalur khusus busway steril hanya untuk armada TransJakarta dan kendaraan darurat yang diizinkan undang-undang (ambulan, pemadam kebakaran).'**
  String get ruleTraffic07Explanation;

  /// No description provided for @ruleTraffic07Dos.
  ///
  /// In id, this message translates to:
  /// **'Tetap melaju di jalur reguler meskipun kondisi lalu lintas padat\nBeri jalan saat armada busway bermanuver di persimpangan'**
  String get ruleTraffic07Dos;

  /// No description provided for @ruleTraffic07Donts.
  ///
  /// In id, this message translates to:
  /// **'Memasuki jalur busway untuk menghindari antrean macet\nBerhenti atau parkir di depan portal jalur busway'**
  String get ruleTraffic07Donts;

  /// No description provided for @ruleTraffic08Title.
  ///
  /// In id, this message translates to:
  /// **'Knalpot Bising & Standar Kelaikan Teknis'**
  String get ruleTraffic08Title;

  /// No description provided for @ruleTraffic08Summary.
  ///
  /// In id, this message translates to:
  /// **'Kendaraan bermotor wajib memenuhi ambang batas kebisingan suara dan kelayakan teknis jalan.'**
  String get ruleTraffic08Summary;

  /// No description provided for @ruleTraffic08Penalty.
  ///
  /// In id, this message translates to:
  /// **'Denda maksimal Rp 250.000 atau kurungan paling lama 1 bulan'**
  String get ruleTraffic08Penalty;

  /// No description provided for @ruleTraffic08Explanation.
  ///
  /// In id, this message translates to:
  /// **'Penggunaan knalpot brong/bising tanpa peredam suara melanggar standar kebisingan desibel Kementerian Lingkungan Hidup dan Kehutanan serta standar kelayakan kendaraan.'**
  String get ruleTraffic08Explanation;

  /// No description provided for @ruleTraffic08Dos.
  ///
  /// In id, this message translates to:
  /// **'Gunakan knalpot standar pabrikan atau yang memiliki sertifikasi desibel resmi\nLakukan uji emisi dan servis berkala'**
  String get ruleTraffic08Dos;

  /// No description provided for @ruleTraffic08Donts.
  ///
  /// In id, this message translates to:
  /// **'Memasang knalpot pipa terbuka (knalpot brong) di jalan umum permukiman\nMelepas spion, lampu sein, atau komponen keselamatan demi estetika balap liar'**
  String get ruleTraffic08Donts;

  /// No description provided for @ruleLabor01Title.
  ///
  /// In id, this message translates to:
  /// **'Batas Jam Kerja & Perhitungan Upah Lembur'**
  String get ruleLabor01Title;

  /// No description provided for @ruleLabor01Summary.
  ///
  /// In id, this message translates to:
  /// **'Maksimal 40 jam kerja per minggu. Lembur maksimal 4 jam/hari dan 18 jam/minggu dengan upah lembur resmi.'**
  String get ruleLabor01Summary;

  /// No description provided for @ruleLabor01Penalty.
  ///
  /// In id, this message translates to:
  /// **'Hak upah lembur wajib dibayarkan perusahaan; sanksi denda pidana bagi pengusaha pelanggar'**
  String get ruleLabor01Penalty;

  /// No description provided for @ruleLabor01Explanation.
  ///
  /// In id, this message translates to:
  /// **'Waktu kerja standar adalah 7 jam/hari (6 hari kerja) atau 8 jam/hari (5 hari kerja). Kerja lembur wajib mendapat persetujuan tertulis pekerja. Upah lembur jam pertama dihitung 1,5x upah sejam, jam berikutnya 2x upah sejam.'**
  String get ruleLabor01Explanation;

  /// No description provided for @ruleLabor01Dos.
  ///
  /// In id, this message translates to:
  /// **'Catat jam masuk dan keluar kerja lembur secara mandiri\nPastikan ada perintah lembur resmi (Surat Perintah Lembur) dari atasan'**
  String get ruleLabor01Dos;

  /// No description provided for @ruleLabor01Donts.
  ///
  /// In id, this message translates to:
  /// **'Bekerja lembur melebihi batas 4 jam per hari atau 18 jam per minggu\nMenerima sistem lembur tanpa kompensasi upah resmi'**
  String get ruleLabor01Donts;

  /// No description provided for @ruleLabor02Title.
  ///
  /// In id, this message translates to:
  /// **'Hak Cuti Tahunan & Hak Cuti Berbayar'**
  String get ruleLabor02Title;

  /// No description provided for @ruleLabor02Summary.
  ///
  /// In id, this message translates to:
  /// **'Pekerja berhak atas cuti tahunan sekurang-kurangnya 12 hari kerja setelah bekerja 12 bulan secara terus-menerus.'**
  String get ruleLabor02Summary;

  /// No description provided for @ruleLabor02Penalty.
  ///
  /// In id, this message translates to:
  /// **'Hak mutlak pekerja berbayar penuh; denda sanksi administratif dan pidana kurungan bagi pengusaha'**
  String get ruleLabor02Penalty;

  /// No description provided for @ruleLabor02Explanation.
  ///
  /// In id, this message translates to:
  /// **'Pengusaha wajib memberikan cuti tahunan sekurang-kurangnya 12 hari kerja dengan upah penuh kepada pekerja yang telah bekerja selama 12 bulan terus-menerus. Cuti melahirkan diberikan 1,5 bulan sebelum dan 1,5 bulan sesudah melahirkan.'**
  String get ruleLabor02Explanation;

  /// No description provided for @ruleLabor02Dos.
  ///
  /// In id, this message translates to:
  /// **'Ajukan rencana cuti tahunan sesuai mekanisme internal perusahaan\nSimpan bukti persetujuan cuti dan sisa saldo cuti resmi'**
  String get ruleLabor02Dos;

  /// No description provided for @ruleLabor02Donts.
  ///
  /// In id, this message translates to:
  /// **'Mengurangi gaji pokok pekerja karena mengambil hak cuti resmi\nMenghanguskan saldo cuti tahunan tanpa mekanisme kompensasi tertulis'**
  String get ruleLabor02Donts;

  /// No description provided for @ruleLabor03Title.
  ///
  /// In id, this message translates to:
  /// **'Tunjangan Hari Raya (THR) Keagamaan'**
  String get ruleLabor03Title;

  /// No description provided for @ruleLabor03Summary.
  ///
  /// In id, this message translates to:
  /// **'THR Keagamaan wajib dibayarkan penuh paling lambat 7 hari (H-7) sebelum hari raya keagamaan.'**
  String get ruleLabor03Summary;

  /// No description provided for @ruleLabor03Penalty.
  ///
  /// In id, this message translates to:
  /// **'Denda keterlambatan 5% dari total THR yang harus dibayar serta sanksi administratif'**
  String get ruleLabor03Penalty;

  /// No description provided for @ruleLabor03Explanation.
  ///
  /// In id, this message translates to:
  /// **'Pengusaha wajib membayarkan THR Keagamaan kepada pekerja yang telah memiliki masa kerja minimal 1 bulan terus-menerus. Masa kerja 12 bulan atau lebih mendapat 1 bulan upah. Masa kerja kurang dari 12 bulan dihitung prorata: (masa kerja / 12) x 1 bulan upah.'**
  String get ruleLabor03Explanation;

  /// No description provided for @ruleLabor03Dos.
  ///
  /// In id, this message translates to:
  /// **'Ketahui tanggal H-7 Idul Fitri / Hari Raya Keagamaan\nLaporkan ke Posko THR Kemnaker jika perusahaan mencicil atau telat membayar THR'**
  String get ruleLabor03Dos;

  /// No description provided for @ruleLabor03Donts.
  ///
  /// In id, this message translates to:
  /// **'Menerima pembayaran THR dalam bentuk parsel atau barang pengganti uang\nMenerima cicilan THR tanpa kesepakatan tertulis resmi yang disahkan Disnaker'**
  String get ruleLabor03Donts;

  /// No description provided for @ruleLabor04Title.
  ///
  /// In id, this message translates to:
  /// **'Kompensasi Pengakhiran Hubungan Kerja (PHK & Pesangon)'**
  String get ruleLabor04Title;

  /// No description provided for @ruleLabor04Summary.
  ///
  /// In id, this message translates to:
  /// **'Perusahaan wajib membayar Uang Pesangon, UPMK, dan UPH sesuai formula masa kerja dan alasan pemutusan hubungan kerja.'**
  String get ruleLabor04Summary;

  /// No description provided for @ruleLabor04Penalty.
  ///
  /// In id, this message translates to:
  /// **'Hak kompensasi wajib dibayar penuh; sanksi perdata PHI & pengawasan Disnaker'**
  String get ruleLabor04Penalty;

  /// No description provided for @ruleLabor04Explanation.
  ///
  /// In id, this message translates to:
  /// **'Dalam hal terjadi PHK, pengusaha wajib membayar kompensasi berupa Uang Pesangon (maksimal 9 bulan upah), Uang Penghargaan Masa Kerja / UPMK (maksimal 10 bulan upah), dan Uang Penggantian Hak (UPH cuti/ongkos pulang). Faktor pengali disesuaikan dengan alasan PHK.'**
  String get ruleLabor04Explanation;

  /// No description provided for @ruleLabor04Dos.
  ///
  /// In id, this message translates to:
  /// **'Mintakan bukti tertulis alasan resmi PHK dari manajemen\nGunakan kalkulator pesangon resmi untuk memverifikasi nominal sebelum tanda tangan'**
  String get ruleLabor04Dos;

  /// No description provided for @ruleLabor04Donts.
  ///
  /// In id, this message translates to:
  /// **'Menandatangani surat pengunduran diri palsu / paksaan yang menghilangkan hak pesangon\nMenerima nominal pesangon di bawah batas minimum regulasi PP 35/2021'**
  String get ruleLabor04Donts;

  /// No description provided for @ruleLabor05Title.
  ///
  /// In id, this message translates to:
  /// **'Kompensasi Pekerja Kontrak (PKWT)'**
  String get ruleLabor05Title;

  /// No description provided for @ruleLabor05Summary.
  ///
  /// In id, this message translates to:
  /// **'Pekerja kontrak (PKWT) berhak mendapat uang kompensasi pada saat berakhirnya jangka waktu kontrak.'**
  String get ruleLabor05Summary;

  /// No description provided for @ruleLabor05Penalty.
  ///
  /// In id, this message translates to:
  /// **'Hak kompensasi wajib diserahkan paling lambat pada hari terakhir masa kontrak'**
  String get ruleLabor05Penalty;

  /// No description provided for @ruleLabor05Explanation.
  ///
  /// In id, this message translates to:
  /// **'Pengusaha wajib memberikan uang kompensasi kepada pekerja PKWT yang telah memiliki masa kerja minimal 1 bulan terus menerus saat kontrak berakhir atau diperpanjang. Formula: (Masa Kerja / 12) x 1 bulan upah.'**
  String get ruleLabor05Explanation;

  /// No description provided for @ruleLabor05Dos.
  ///
  /// In id, this message translates to:
  /// **'Pastikan perjanjian kerja memuat tanggal mulai dan berakhirnya kontrak secara tegas\nHitung hak kompensasi PKWT setiap kali periode perpanjangan kontrak selesai'**
  String get ruleLabor05Dos;

  /// No description provided for @ruleLabor05Donts.
  ///
  /// In id, this message translates to:
  /// **'Menganggap pekerja kontrak tidak memiliki hak pesangon/kompensasi sama sekali\nMemperkerjakan PKWT untuk pekerjaan yang bersifat tetap terus menerus tanpa batas'**
  String get ruleLabor05Donts;

  /// No description provided for @ruleLabor06Title.
  ///
  /// In id, this message translates to:
  /// **'Kewajiban Kepesertaan BPJS Ketenagakerjaan'**
  String get ruleLabor06Title;

  /// No description provided for @ruleLabor06Summary.
  ///
  /// In id, this message translates to:
  /// **'Perusahaan wajib mendaftarkan seluruh pekerja ke program BPJS Ketenagakerjaan (JKK, JKM, JHT, JP).'**
  String get ruleLabor06Summary;

  /// No description provided for @ruleLabor06Penalty.
  ///
  /// In id, this message translates to:
  /// **'Sanksi tidak mendapat pelayanan publik tertentu bagi pengusaha dan denda keterlambatan'**
  String get ruleLabor06Penalty;

  /// No description provided for @ruleLabor06Explanation.
  ///
  /// In id, this message translates to:
  /// **'Setiap pemberi kerja wajib mendaftarkan pekerjanya dalam program Jaminan Kecelakaan Kerja (JKK), Jaminan Kematian (JKM), Jaminan Hari Tua (JHT), dan Jaminan Pensiun (JP) serta menyetorkan iurannya secara tertib.'**
  String get ruleLabor06Explanation;

  /// No description provided for @ruleLabor06Dos.
  ///
  /// In id, this message translates to:
  /// **'Cek saldo JHT dan status kepesertaan aktif melalui aplikasi JMO secara berkala\nLaporkan ke Disnaker jika potongan upah BPJS tidak disetorkan oleh perusahaan'**
  String get ruleLabor06Dos;

  /// No description provided for @ruleLabor06Donts.
  ///
  /// In id, this message translates to:
  /// **'Menerima pemotongan upah sepihak tanpa adanya kartu peserta BPJS resmi\nBekerja di lingkungan bahaya tanpa proteksi Jaminan Kecelakaan Kerja (JKK)'**
  String get ruleLabor06Donts;

  /// No description provided for @rulePrivacy01Title.
  ///
  /// In id, this message translates to:
  /// **'Pencemaran Nama Baik & Delik Aduan Siber'**
  String get rulePrivacy01Title;

  /// No description provided for @rulePrivacy01Summary.
  ///
  /// In id, this message translates to:
  /// **'Penyerangan kehormatan di media elektronik adalah delik aduan absolut; kritik publik bukan pidana.'**
  String get rulePrivacy01Summary;

  /// No description provided for @rulePrivacy01Penalty.
  ///
  /// In id, this message translates to:
  /// **'Pidana penjara maksimal 2 tahun dan/atau denda maksimal Rp 400.000.000'**
  String get rulePrivacy01Penalty;

  /// No description provided for @rulePrivacy01Explanation.
  ///
  /// In id, this message translates to:
  /// **'UU ITE Revisi Kedua No. 1/2024 menegaskan bahwa tindak pidana pencemaran nama baik adalah delik aduan absolut yang hanya bisa dilaporkan oleh korban perseorangan langsung. Ditegaskan pula perbuatan tidak dipidana jika dilakukan demi kepentingan umum atau terpaksa membela diri.'**
  String get rulePrivacy01Explanation;

  /// No description provided for @rulePrivacy01Dos.
  ///
  /// In id, this message translates to:
  /// **'Sampaikan kritik dengan basis fakta, data, dan rujukan yang dapat dibuktikan\nGunakan bahasa etis tanpa melontarkan umpatan atau kata penghinaan pribadi'**
  String get rulePrivacy01Dos;

  /// No description provided for @rulePrivacy01Donts.
  ///
  /// In id, this message translates to:
  /// **'Menyebarkan tuduhan asusila atau fitnah tanpa bukti di media sosial terbuka\nMenggunakan nama orang lain untuk membuat akun gosip palsu'**
  String get rulePrivacy01Donts;

  /// No description provided for @rulePrivacy02Title.
  ///
  /// In id, this message translates to:
  /// **'Hak Subjek Data Pribadi (UU PDP)'**
  String get rulePrivacy02Title;

  /// No description provided for @rulePrivacy02Summary.
  ///
  /// In id, this message translates to:
  /// **'Masyarakat berhak mengakses, memperbaiki, menghapus, dan menarik persetujuan pemrosesan data pribadi.'**
  String get rulePrivacy02Summary;

  /// No description provided for @rulePrivacy02Penalty.
  ///
  /// In id, this message translates to:
  /// **'Denda administratif hingga 2% dari total pendapatan tahunan korporasi pelanggar'**
  String get rulePrivacy02Penalty;

  /// No description provided for @rulePrivacy02Explanation.
  ///
  /// In id, this message translates to:
  /// **'UU Perlindungan Data Pribadi (UU PDP) menjamin hak subjek data untuk meminta salinan data, mengubah ketidakakuratan, membatasi pemrosesan, dan menuntut ganti rugi atas pelanggaran kebocoran data pribadi oleh korporasi atau badan publik.'**
  String get rulePrivacy02Explanation;

  /// No description provided for @rulePrivacy02Dos.
  ///
  /// In id, this message translates to:
  /// **'Ajukan permohonan tertulis penghapusan data akun saat berhenti memakai layanan digital\nPeriksa izin akses kontak, mikrofon, dan lokasi pada aplikasi smartphone'**
  String get rulePrivacy02Dos;

  /// No description provided for @rulePrivacy02Donts.
  ///
  /// In id, this message translates to:
  /// **'Membagikan foto KTP, Kartu Keluarga, atau nomor rekening di grup pesan publik\nMenyetujui syarat & ketentuan aplikasi yang meminta akses data tidak relevan'**
  String get rulePrivacy02Donts;

  /// No description provided for @rulePrivacy03Title.
  ///
  /// In id, this message translates to:
  /// **'Kewajiban Notifikasi Kebocoran Data (Aturan 72 Jam)'**
  String get rulePrivacy03Title;

  /// No description provided for @rulePrivacy03Summary.
  ///
  /// In id, this message translates to:
  /// **'Pengendali data wajib menyampaikan pemberitahuan tertulis kebocoran data maksimal 3x24 jam (72 jam).'**
  String get rulePrivacy03Summary;

  /// No description provided for @rulePrivacy03Penalty.
  ///
  /// In id, this message translates to:
  /// **'Sanksi peringatan tertulis, pembekuan kegiatan bisnis, hingga denda administratif raksasa'**
  String get rulePrivacy03Penalty;

  /// No description provided for @rulePrivacy03Explanation.
  ///
  /// In id, this message translates to:
  /// **'Dalam hal terjadi kegagalan perlindungan data pribadi (data breach), Pengendali Data Pribadi wajib menyampaikan pemberitahuan tertulis paling lambat 72 jam kepada Subjek Data Pribadi dan lembaga pengawas resmi.'**
  String get rulePrivacy03Explanation;

  /// No description provided for @rulePrivacy03Dos.
  ///
  /// In id, this message translates to:
  /// **'Segera ganti kata sandi dan aktifkan 2-Factor Authentication (2FA) jika ada pemberitahuan kebocoran\nPantau mutasi rekening bank dan peringatan login akun yang mencurigakan'**
  String get rulePrivacy03Dos;

  /// No description provided for @rulePrivacy03Donts.
  ///
  /// In id, this message translates to:
  /// **'Menyembunyikan insiden peretasan sistem dari publik dan otoritas pengawas\nMengabaikan email notifikasi keamanan dari platform terpercaya'**
  String get rulePrivacy03Donts;

  /// No description provided for @rulePrivacy04Title.
  ///
  /// In id, this message translates to:
  /// **'Larangan Penyebaran Data Pribadi Tanpa Hak (Doxxing)'**
  String get rulePrivacy04Title;

  /// No description provided for @rulePrivacy04Summary.
  ///
  /// In id, this message translates to:
  /// **'Dilarang keras menyebarkan data pribadi orang lain untuk mengintimidasi atau merugikan korban.'**
  String get rulePrivacy04Summary;

  /// No description provided for @rulePrivacy04Penalty.
  ///
  /// In id, this message translates to:
  /// **'Pidana penjara paling lama 5 tahun dan/atau pidana denda paling banyak Rp 5.000.000.000'**
  String get rulePrivacy04Penalty;

  /// No description provided for @rulePrivacy04Explanation.
  ///
  /// In id, this message translates to:
  /// **'Tindakan menyebarkan KTP, nomor telepon, alamat rumah, atau data finansial orang lain di internet dengan maksud mencelakakan atau mengintimidasi korban (doxxing) diancam sanksi pidana berat.'**
  String get rulePrivacy04Explanation;

  /// No description provided for @rulePrivacy04Dos.
  ///
  /// In id, this message translates to:
  /// **'Sensor (blur) nama lengkap, NIK, dan nomor telepon saat membagikan bukti transaksi\nLaporkan konten doxxing ke tim moderasi platform dan patroli siber kepolisian'**
  String get rulePrivacy04Dos;

  /// No description provided for @rulePrivacy04Donts.
  ///
  /// In id, this message translates to:
  /// **'Memposting KTP lawan transaksi di medsos dengan dalih penagihan utang / viralitas\nMembuat database data pribadi warga tanpa persetujuan eksplisit pemilik data'**
  String get rulePrivacy04Donts;

  /// No description provided for @rulePrivacy05Title.
  ///
  /// In id, this message translates to:
  /// **'Jerat Pidana Penipuan Transaksi Online & Phishing'**
  String get rulePrivacy05Title;

  /// No description provided for @rulePrivacy05Summary.
  ///
  /// In id, this message translates to:
  /// **'Menyebarkan informasi bohong dalam transaksi elektronik yang merugikan konsumen diancam pidana.'**
  String get rulePrivacy05Summary;

  /// No description provided for @rulePrivacy05Penalty.
  ///
  /// In id, this message translates to:
  /// **'Pidana penjara paling lama 6 tahun dan/atau denda paling banyak Rp 1.000.000.000'**
  String get rulePrivacy05Penalty;

  /// No description provided for @rulePrivacy05Explanation.
  ///
  /// In id, this message translates to:
  /// **'Setiap orang yang dengan sengaja menyebarkan berita bohong dan menyesatkan dalam transaksi elektronik (toko online palsu, link phishing file APK, investasi bodong) dijerat pasal tindak pidana siber.'**
  String get rulePrivacy05Explanation;

  /// No description provided for @rulePrivacy05Dos.
  ///
  /// In id, this message translates to:
  /// **'Gunakan fitur rekening bersama (rekber) resmi atau marketplace terpercaya\nCek kredibilitas nomor rekening tujuan di portal cekrekening.id resmi pemerintah'**
  String get rulePrivacy05Dos;

  /// No description provided for @rulePrivacy05Donts.
  ///
  /// In id, this message translates to:
  /// **'Mengunduh atau mengklik file ekstensi .APK misterius dari WhatsApp\nMentransfer uang langsung tanpa jaminan escrow ke penjual anonim'**
  String get rulePrivacy05Donts;

  /// No description provided for @ruleConsumer01Title.
  ///
  /// In id, this message translates to:
  /// **'Hak Kompensasi & Ganti Rugi Barang Rusak'**
  String get ruleConsumer01Title;

  /// No description provided for @ruleConsumer01Summary.
  ///
  /// In id, this message translates to:
  /// **'Konsumen berhak mendapat kompensasi, ganti rugi, atau penggantian jika barang yang diterima cacat.'**
  String get ruleConsumer01Summary;

  /// No description provided for @ruleConsumer01Penalty.
  ///
  /// In id, this message translates to:
  /// **'Pidana penjara paling lama 5 tahun atau pidana denda paling banyak Rp 2.000.000.000'**
  String get ruleConsumer01Penalty;

  /// No description provided for @ruleConsumer01Explanation.
  ///
  /// In id, this message translates to:
  /// **'Pasal 19 UU Perlindungan Konsumen No. 8/1999 mewajibkan pelaku usaha memberikan ganti rugi berupa pengembalian uang atau penggantian barang sejenis atas kerusakan, pencemaran, atau kerugian akibat mengonsumsi barang/jasa.'**
  String get ruleConsumer01Explanation;

  /// No description provided for @ruleConsumer01Dos.
  ///
  /// In id, this message translates to:
  /// **'Rekam video unboxing paket tanpa jeda sejak kardus masih tersegel rapat\nSimpan nota pembelian, invoice digital, dan bukti pembayaran transaksi'**
  String get ruleConsumer01Dos;

  /// No description provided for @ruleConsumer01Donts.
  ///
  /// In id, this message translates to:
  /// **'Menerima paket dengan segel terbuka tanpa membuat berita acara kurir\nMembuang struk fisik sebelum barang selesai diuji coba fungsinya'**
  String get ruleConsumer01Donts;

  /// No description provided for @ruleConsumer02Title.
  ///
  /// In id, this message translates to:
  /// **'Larangan Klausula Baku Sepihak (\"Barang Tidak Boleh Ditukar\")'**
  String get ruleConsumer02Title;

  /// No description provided for @ruleConsumer02Summary.
  ///
  /// In id, this message translates to:
  /// **'Klausul pencantuman \"barang yang sudah dibeli tidak dapat ditukar/dikembalikan\" dinyatakan batal demi hukum.'**
  String get ruleConsumer02Summary;

  /// No description provided for @ruleConsumer02Penalty.
  ///
  /// In id, this message translates to:
  /// **'Pidana penjara paling lama 5 tahun atau denda maksimal Rp 2.000.000.000'**
  String get ruleConsumer02Penalty;

  /// No description provided for @ruleConsumer02Explanation.
  ///
  /// In id, this message translates to:
  /// **'Pasal 18 UU Perlindungan Konsumen melarang pelaku usaha mencantumkan klausula baku yang mengalihkan tanggung jawab, termasuk klausula sepihak menolak pengembalian barang jika barang tersebut terbukti cacat tersembunyi.'**
  String get ruleConsumer02Explanation;

  /// No description provided for @ruleConsumer02Dos.
  ///
  /// In id, this message translates to:
  /// **'Tuntut hak retur jika produk terbukti cacat pabrik meskipun ada tulisan larangan di nota\nLaporkan klausula baku zalim ke Badan Penyelesaian Sengketa Konsumen (BPSK)'**
  String get ruleConsumer02Dos;

  /// No description provided for @ruleConsumer02Donts.
  ///
  /// In id, this message translates to:
  /// **'Pasrah saat pedagang menolak retur barang rusak dengan alasan tulisan di struk\nMembuat surat perjanjian jual beli yang menghilangkan hak komplain pembeli'**
  String get ruleConsumer02Donts;

  /// No description provided for @ruleConsumer03Title.
  ///
  /// In id, this message translates to:
  /// **'Kewajiban Label Bahasa Indonesia & Kedaluwarsa'**
  String get ruleConsumer03Title;

  /// No description provided for @ruleConsumer03Summary.
  ///
  /// In id, this message translates to:
  /// **'Barang beredar wajib mencantumkan label informasi bahasa Indonesia dan tanggal kedaluwarsa yang jelas.'**
  String get ruleConsumer03Summary;

  /// No description provided for @ruleConsumer03Penalty.
  ///
  /// In id, this message translates to:
  /// **'Pidana penjara paling lama 5 tahun atau denda maksimal Rp 2.000.000.000'**
  String get ruleConsumer03Penalty;

  /// No description provided for @ruleConsumer03Explanation.
  ///
  /// In id, this message translates to:
  /// **'Pelaku usaha dilarang memperdagangkan barang yang tidak mencantumkan label petunjuk penggunaan dalam bahasa Indonesia, nomor izin edar resmi (BPOM/SNI), serta tanggal kedaluwarsa pada kemasan.'**
  String get ruleConsumer03Explanation;

  /// No description provided for @ruleConsumer03Dos.
  ///
  /// In id, this message translates to:
  /// **'Cek tanggal kedaluwarsa dan nomor izin edar BPOM sebelum membeli produk makanan/kosmetik\nPastikan petunjuk keamanan dan komposisi bahan tertera jelas pada kemasan'**
  String get ruleConsumer03Dos;

  /// No description provided for @ruleConsumer03Donts.
  ///
  /// In id, this message translates to:
  /// **'Membeli produk kosmetik atau obat impor tanpa label izin resmi BPOM\nMenjual kembali produk pangan yang sudah melewati tanggal kedaluwarsa'**
  String get ruleConsumer03Donts;

  /// No description provided for @ruleConsumer04Title.
  ///
  /// In id, this message translates to:
  /// **'Hak Informasi Akurat & Larangan Iklan Menyesatkan'**
  String get ruleConsumer04Title;

  /// No description provided for @ruleConsumer04Summary.
  ///
  /// In id, this message translates to:
  /// **'Pelaku usaha dilarang mengiklankan produk secara menyesatkan, bohong, atau berlebihan.'**
  String get ruleConsumer04Summary;

  /// No description provided for @ruleConsumer04Penalty.
  ///
  /// In id, this message translates to:
  /// **'Pidana penjara paling lama 5 tahun atau denda maksimal Rp 2.000.000.000'**
  String get ruleConsumer04Penalty;

  /// No description provided for @ruleConsumer04Explanation.
  ///
  /// In id, this message translates to:
  /// **'Pasal 9 & 10 UU Perlindungan Konsumen melarang penawaran barang/jasa dengan menyajikan klaim mutu, diskon fiktif, atau testimoni palsu yang menyesatkan dan menipu konsumen.'**
  String get ruleConsumer04Explanation;

  /// No description provided for @ruleConsumer04Dos.
  ///
  /// In id, this message translates to:
  /// **'Bandingkan riwayat harga barang sebelum promo untuk mengonfirmasi diskon riil\nKritisi klaim medis instan pada produk suplemen non-resep dokter'**
  String get ruleConsumer04Dos;

  /// No description provided for @ruleConsumer04Donts.
  ///
  /// In id, this message translates to:
  /// **'Membuat promo diskon palsu dengan menaikkan harga dasar secara drastis terlebih dahulu\nMenggunakan testimoni rekayasa / influencer bayaran tanpa klausul iklan berbayar'**
  String get ruleConsumer04Donts;

  /// No description provided for @ruleSafety01Title.
  ///
  /// In id, this message translates to:
  /// **'Kewajiban APAR & Jalur Evakuasi Bangunan Gedung'**
  String get ruleSafety01Title;

  /// No description provided for @ruleSafety01Summary.
  ///
  /// In id, this message translates to:
  /// **'Gedung publik dan tempat usaha wajib menyediakan APAR terinspeksi dan jalur evakuasi bebas hambatan.'**
  String get ruleSafety01Summary;

  /// No description provided for @ruleSafety01Penalty.
  ///
  /// In id, this message translates to:
  /// **'Peringatan tertulis, pembekuan Sertifikat Laik Fungsi (SLF), hingga penutupan operasional'**
  String get ruleSafety01Penalty;

  /// No description provided for @ruleSafety01Explanation.
  ///
  /// In id, this message translates to:
  /// **'Permenaker No. 04/1980 dan Permen PUPR No. 14/2021 mewajibkan setiap bangunan komersial menyediakan Alat Pemadam Api Ringan (APAR) siap pakai setiap jarak 15 meter, tangga darurat bertekanan, dan pintu evakuasi yang tidak terkunci saat jam kerja.'**
  String get ruleSafety01Explanation;

  /// No description provided for @ruleSafety01Dos.
  ///
  /// In id, this message translates to:
  /// **'Periksa jarum tekanan APAR berada di zona hijau dan balik tabung secara berkala\nPastikan koridor tangga darurat bebas dari tumpukan barang bekas'**
  String get ruleSafety01Dos;

  /// No description provided for @ruleSafety01Donts.
  ///
  /// In id, this message translates to:
  /// **'Mengunci pintu darurat atau merantai handel pintu keluar evakuasi dengan gembok\nMenutupi rambu petunjuk \"EXIT\" menyala dengan spanduk promosi'**
  String get ruleSafety01Donts;

  /// No description provided for @ruleSafety02Title.
  ///
  /// In id, this message translates to:
  /// **'Standar K3 Konstruksi & Penggunaan APD Wajib'**
  String get ruleSafety02Title;

  /// No description provided for @ruleSafety02Summary.
  ///
  /// In id, this message translates to:
  /// **'Pekerja dan pengawas di area proyek wajib mengenakan Alat Pelindung Diri (APD) standar SNI/ISO.'**
  String get ruleSafety02Summary;

  /// No description provided for @ruleSafety02Penalty.
  ///
  /// In id, this message translates to:
  /// **'Denda administratif, penghentian sementara proyek konstruksi, hingga pencabutan izin usaha'**
  String get ruleSafety02Penalty;

  /// No description provided for @ruleSafety02Explanation.
  ///
  /// In id, this message translates to:
  /// **'UU Keselamatan Kerja No. 1/1970 mewajibkan kontraktor menyediakan helm pengaman (safety helmet), sepatu safety boots, rompi reflektif, dan tali keselamatan (full body harness) saat bekerja pada ketinggian di atas 1,8 meter.'**
  String get ruleSafety02Explanation;

  /// No description provided for @ruleSafety02Dos.
  ///
  /// In id, this message translates to:
  /// **'Kaitkan kait ganda karabiner safety harness ke pipa scaffolding / lifeline kokoh\nGunakan helm keselamatan dengan tali dagu terpasang kencang di zona proyek'**
  String get ruleSafety02Dos;

  /// No description provided for @ruleSafety02Donts.
  ///
  /// In id, this message translates to:
  /// **'Memasuki area konstruksi proyek aktif hanya memakai sandal jepit atau sepatu kasual\nBekerja pada scaffolding bambu tanpa railing pengaman jatuh (fall protection)'**
  String get ruleSafety02Donts;

  /// No description provided for @ruleSafety03Title.
  ///
  /// In id, this message translates to:
  /// **'Larangan Merokok di Kawasan Tanpa Rokok (KTR)'**
  String get ruleSafety03Title;

  /// No description provided for @ruleSafety03Summary.
  ///
  /// In id, this message translates to:
  /// **'Dilarang merokok dan vape di fasilitas kesehatan, sekolah, tempat ibadah, angkutan umum, dan ruang tertutup.'**
  String get ruleSafety03Summary;

  /// No description provided for @ruleSafety03Penalty.
  ///
  /// In id, this message translates to:
  /// **'Denda perorangan hingga Rp 50.000.000 atau kurungan penjara maksimal 6 bulan (tergantung Perda)'**
  String get ruleSafety03Penalty;

  /// No description provided for @ruleSafety03Explanation.
  ///
  /// In id, this message translates to:
  /// **'UU Kesehatan No. 17/2023 mewajibkan pengelola gedung menetapkan Kawasan Tanpa Rokok (KTR). Pelanggaran merokok konvensional maupun rokok elektronik di area KTR dikenakan sanksi denda tegas oleh Satpol PP.'**
  String get ruleSafety03Explanation;

  /// No description provided for @ruleSafety03Dos.
  ///
  /// In id, this message translates to:
  /// **'Merokok hanya pada area khusus terbuka (smoking area) yang jauh dari akses keluar-masuk\nMatikan puntung rokok di asbak sampai benar-benar padam tanpa bara api tersisa'**
  String get ruleSafety03Dos;

  /// No description provided for @ruleSafety03Donts.
  ///
  /// In id, this message translates to:
  /// **'Menghisap rokok atau pod vape di lorong rumah sakit, ruang kelas, atau dalam lift\nMembuang puntung rokok yang masih menyala ke tempat sampah kering / rumput kering'**
  String get ruleSafety03Donts;

  /// No description provided for @ruleSafety04Title.
  ///
  /// In id, this message translates to:
  /// **'Prosedur Tanggap Darurat & Hak Menolak Kerja Berbahaya'**
  String get ruleSafety04Title;

  /// No description provided for @ruleSafety04Summary.
  ///
  /// In id, this message translates to:
  /// **'Pekerja berhak menolak pekerjaan jika lingkungan kerja mengancam nyawa tanpa perlindungan memadai.'**
  String get ruleSafety04Summary;

  /// No description provided for @ruleSafety04Penalty.
  ///
  /// In id, this message translates to:
  /// **'Sanksi pidana kurungan atau denda bagi pengusaha yang memaksa pekerja bekerja dalam bahaya ekstrem'**
  String get ruleSafety04Penalty;

  /// No description provided for @ruleSafety04Explanation.
  ///
  /// In id, this message translates to:
  /// **'Pasal 12 huruf d UU No. 1/1970 menjamin hak tenaga kerja untuk menyatakan keberatan dan menolak bekerja pada pekerjaan di mana syarat keselamatan dan kesehatan kerja (K3) serta APD tidak dipenuhi dan membahayakan keselamatan jiwanya.'**
  String get ruleSafety04Explanation;

  /// No description provided for @ruleSafety04Dos.
  ///
  /// In id, this message translates to:
  /// **'Laporkan kondisi unsafe condition atau unsafe action kepada Ahli K3 / Supervisor kerja\nHafalkan titik kumpul aman (Assembly Point) di area lingkungan kerja Anda'**
  String get ruleSafety04Dos;

  /// No description provided for @ruleSafety04Donts.
  ///
  /// In id, this message translates to:
  /// **'Memaksa masuk ke ruang terbatas (confined space) tanpa blower sirkulasi dan gas detector\nMenghukum atau memotong gaji buruh yang menolak tugas berisiko tinggi tanpa APD'**
  String get ruleSafety04Donts;

  /// No description provided for @ruleEthics01Title.
  ///
  /// In id, this message translates to:
  /// **'Larangan Gratifikasi & Suap Pejabat Publik'**
  String get ruleEthics01Title;

  /// No description provided for @ruleEthics01Summary.
  ///
  /// In id, this message translates to:
  /// **'Pemberian hadiah atau fasilitas kepada pegawai negeri/penyelenggara negara dianggap suap bila berhubungan dengan jabatannya.'**
  String get ruleEthics01Summary;

  /// No description provided for @ruleEthics01Penalty.
  ///
  /// In id, this message translates to:
  /// **'Pidana penjara seumur hidup atau 4-20 tahun dan denda hingga Rp 1.000.000.000'**
  String get ruleEthics01Penalty;

  /// No description provided for @ruleEthics01Explanation.
  ///
  /// In id, this message translates to:
  /// **'Pasal 12B UU Tindak Pidana Korupsi (UU Tipikor) menyatakan setiap gratifikasi kepada pegawai negeri dianggap suap jika berhubungan dengan jabatan dan berlawanan dengan kewajibannya, kecuali dilaporkan ke KPK dalam waktu maksimal 30 hari kerja.'**
  String get ruleEthics01Explanation;

  /// No description provided for @ruleEthics01Dos.
  ///
  /// In id, this message translates to:
  /// **'Laporkan setiap penerimaan parsel/bingkisan dinas ke Unit Pengendalian Gratifikasi (UPG) atau KPK\nTolak tawaran amplop pelicin atau fasilitas akomodasi mewah dari vendor tender'**
  String get ruleEthics01Dos;

  /// No description provided for @ruleEthics01Donts.
  ///
  /// In id, this message translates to:
  /// **'Memberi parsel lebaran atau cinderamata mahal kepada pejabat pembuat komitmen proyek\nMenitipkan uang pelicin di loket pelayanan izin publik untuk mempercepat antrean'**
  String get ruleEthics01Donts;

  /// No description provided for @ruleEthics02Title.
  ///
  /// In id, this message translates to:
  /// **'Perlindungan Saksi & Pelapor Pidana (Whistleblower)'**
  String get ruleEthics02Title;

  /// No description provided for @ruleEthics02Summary.
  ///
  /// In id, this message translates to:
  /// **'Pelapor tindak pidana korupsi dan kejahatan terorganisir dijamin kerahasiaan identitas dan perlindungan fisik hukum.'**
  String get ruleEthics02Summary;

  /// No description provided for @ruleEthics02Penalty.
  ///
  /// In id, this message translates to:
  /// **'Pidana penjara hingga 7 tahun bagi pihak yang mengintimidasi atau membalas dendam kepada saksi/korban'**
  String get ruleEthics02Penalty;

  /// No description provided for @ruleEthics02Explanation.
  ///
  /// In id, this message translates to:
  /// **'UU Perlindungan Saksi dan Korban (UU LPSK) menjamin saksi dan pelapor (whistleblower) tidak dapat dituntut secara hukum, baik perdata maupun pidana, atas laporan kesaksian yang akan atau telah diberikannya secara beriktikad baik.'**
  String get ruleEthics02Explanation;

  /// No description provided for @ruleEthics02Dos.
  ///
  /// In id, this message translates to:
  /// **'Kumpulkan bukti dokumen, rekaman, atau alur transaksi sebelum melapor ke LPSK / KPK\nGunakan kanal pengaduan resmi terenkripsi (Whistleblowing System / WBS)'**
  String get ruleEthics02Dos;

  /// No description provided for @ruleEthics02Donts.
  ///
  /// In id, this message translates to:
  /// **'Membongkar identitas asli pelapor tindak pidana di lingkungan kantor atau medsos terbuka\nMemberikan sanksi mutasi jabatan atau PHK kepada pegawai yang melaporkan kecurangan korporasi'**
  String get ruleEthics02Donts;

  /// No description provided for @ruleEthics03Title.
  ///
  /// In id, this message translates to:
  /// **'Larangan Benturan Kepentingan Pengadaan Barang & Jasa'**
  String get ruleEthics03Title;

  /// No description provided for @ruleEthics03Summary.
  ///
  /// In id, this message translates to:
  /// **'Pejabat pengadaan dilarang mengikutsertakan perusahaan milik pribadi atau keluarga dalam lelang proyek.'**
  String get ruleEthics03Summary;

  /// No description provided for @ruleEthics03Penalty.
  ///
  /// In id, this message translates to:
  /// **'Pembatalan kontrak sepihak, sanksi daftar hitam (blacklist), dan tuntutan korupsi pasal 12i UU Tipikor'**
  String get ruleEthics03Penalty;

  /// No description provided for @ruleEthics03Explanation.
  ///
  /// In id, this message translates to:
  /// **'Pasal 12 huruf i UU Tipikor dan aturan LKPP melarang pejabat atau aparatur sipil negara baik langsung maupun tidak langsung turut serta dalam pemborongan, pengadaan, atau persewaan yang pada saat dilakukan perbuatan, seluruh atau sebagian ditugaskan untuk mengurus atau mengawasinya.'**
  String get ruleEthics03Explanation;

  /// No description provided for @ruleEthics03Dos.
  ///
  /// In id, this message translates to:
  /// **'Deklarasikan Surat Pernyataan Bebas Benturan Kepentingan sebelum panitia lelang dibentuk\nUndurkan diri dari proses evaluasi tender jika peserta tender memiliki hubungan darah/afinitas'**
  String get ruleEthics03Dos;

  /// No description provided for @ruleEthics03Donts.
  ///
  /// In id, this message translates to:
  /// **'Memenangkan vendor titipan kenalan tanpa verifikasi teknis dan adu harga kompetitif\nMemecah paket pengadaan agar terhindar dari kewajiban lelang terbuka sistem elektronik'**
  String get ruleEthics03Donts;

  /// No description provided for @ruleEthics04Title.
  ///
  /// In id, this message translates to:
  /// **'Kerahasiaan Medis & Hubungan Dokter-Pasien'**
  String get ruleEthics04Title;

  /// No description provided for @ruleEthics04Summary.
  ///
  /// In id, this message translates to:
  /// **'Tenaga kesehatan wajib menjaga kerahasiaan rekam medis dan data kesehatan pasien.'**
  String get ruleEthics04Summary;

  /// No description provided for @ruleEthics04Penalty.
  ///
  /// In id, this message translates to:
  /// **'Sanksi disiplin etik kedokteran, pencabutan Surat Izin Praktik (SIP), hingga pidana pembocoran rahasia'**
  String get ruleEthics04Penalty;

  /// No description provided for @ruleEthics04Explanation.
  ///
  /// In id, this message translates to:
  /// **'Pasal 296 UU Kesehatan No. 17/2023 dan Permenkes tentang Rekam Medis menegaskan bahwa isi rekam medis adalah rahasia dan milik pasien. Pembukaan rekam medis tanpa izin pasien hanya diizinkan untuk kepentingan penegakan hukum resmi.'**
  String get ruleEthics04Explanation;

  /// No description provided for @ruleEthics04Dos.
  ///
  /// In id, this message translates to:
  /// **'Minta surat persetujuan tertulis (informed consent) sebelum melakukan tindakan medis invasif\nSimpan rekam medis fisik dalam lemari terkunci atau rekam medis elektronik terenkripsi'**
  String get ruleEthics04Dos;

  /// No description provided for @ruleEthics04Donts.
  ///
  /// In id, this message translates to:
  /// **'Menceritakan riwayat penyakit atau foto kondisi luka pasien di media sosial pribadi\nMenyerahkan salinan resume medis kepada pihak asuransi tanpa otorisasi bertandatangan pasien'**
  String get ruleEthics04Donts;

  /// No description provided for @shareRuleCard.
  ///
  /// In id, this message translates to:
  /// **'Bagikan Kartu Aturan'**
  String get shareRuleCard;

  /// No description provided for @shareRuleCardFailed.
  ///
  /// In id, this message translates to:
  /// **'Gagal membagikan kartu aturan'**
  String get shareRuleCardFailed;

  /// No description provided for @shareRuleCardDownloaded.
  ///
  /// In id, this message translates to:
  /// **'Kartu aturan berhasil disimpan'**
  String get shareRuleCardDownloaded;

  /// No description provided for @shareRuleTextCopied.
  ///
  /// In id, this message translates to:
  /// **'Teks aturan berhasil disalin'**
  String get shareRuleTextCopied;

  /// No description provided for @shareCopyText.
  ///
  /// In id, this message translates to:
  /// **'Salin Teks'**
  String get shareCopyText;

  /// No description provided for @shareDownloadImage.
  ///
  /// In id, this message translates to:
  /// **'Simpan Gambar'**
  String get shareDownloadImage;

  /// No description provided for @sharePreparing.
  ///
  /// In id, this message translates to:
  /// **'Menyiapkan kartu...'**
  String get sharePreparing;

  /// No description provided for @shareConsequenceHeader.
  ///
  /// In id, this message translates to:
  /// **'KONSEKUENSI HUKUM'**
  String get shareConsequenceHeader;

  /// No description provided for @readBadgeTitle.
  ///
  /// In id, this message translates to:
  /// **'Lencana Literasi Hukum'**
  String get readBadgeTitle;

  /// No description provided for @readBadgeShareTooltip.
  ///
  /// In id, this message translates to:
  /// **'Bagikan pencapaian literasi hukum'**
  String get readBadgeShareTooltip;

  /// No description provided for @tierNew.
  ///
  /// In id, this message translates to:
  /// **'Pemula'**
  String get tierNew;

  /// No description provided for @tierReader.
  ///
  /// In id, this message translates to:
  /// **'Pembaca Hukum'**
  String get tierReader;

  /// No description provided for @tierLearner.
  ///
  /// In id, this message translates to:
  /// **'Pemerhati Aturan'**
  String get tierLearner;

  /// No description provided for @tierScholar.
  ///
  /// In id, this message translates to:
  /// **'Cendekia Hukum'**
  String get tierScholar;

  /// No description provided for @tierExpert.
  ///
  /// In id, this message translates to:
  /// **'Pakar Regulasi'**
  String get tierExpert;
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
