class AppConstants {
  static const String appName = 'RuleBook';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Pocket Rules, Regulations & Guidelines';
  static const String appDomain = 'https://rulebook.faishal.id';
  static const String fleetHome = 'https://faishal.id';

  // Storage Keys
  static const String keyBookmarks = 'rulebook_bookmarked_ids';
  static const String keyRecentSearch = 'rulebook_recent_searches';
  static const String keyCustomNotes = 'rulebook_user_notes';

  // Validation Limits (§VAL)
  static const int minSearchLength = 1;
  static const int maxSearchLength = 60;
  static const int maxNoteLength = 500;
}
