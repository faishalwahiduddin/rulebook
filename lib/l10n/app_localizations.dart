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
  /// **'Tersimpan'**
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
  /// **'Catatan Pribadi'**
  String get personalNote;

  /// No description provided for @addNote.
  ///
  /// In id, this message translates to:
  /// **'Tambah Catatan'**
  String get addNote;

  /// No description provided for @noteSaved.
  ///
  /// In id, this message translates to:
  /// **'Catatan berhasil disimpan!'**
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
