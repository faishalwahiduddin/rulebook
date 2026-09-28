import 'rule_category.dart';

class RuleItem {
  final String id;
  final String title;
  final RuleCategory category;
  final String summary;
  final String fullExplanation;
  final String legalBasis;
  final String penaltyOrRight;
  final List<String> keyDos;
  final List<String> keyDonts;
  final List<String> keywords;

  const RuleItem({
    required this.id,
    required this.title,
    required this.category,
    required this.summary,
    required this.fullExplanation,
    required this.legalBasis,
    required this.penaltyOrRight,
    required this.keyDos,
    required this.keyDonts,
    required this.keywords,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category.name,
        'summary': summary,
        'fullExplanation': fullExplanation,
        'legalBasis': legalBasis,
        'penaltyOrRight': penaltyOrRight,
        'keyDos': keyDos,
        'keyDonts': keyDonts,
        'keywords': keywords,
      };

  factory RuleItem.fromJson(Map<String, dynamic> json) => RuleItem(
        id: json['id'] as String,
        title: json['title'] as String,
        category: RuleCategory.values.firstWhere(
          (c) => c.name == json['category'],
          orElse: () => RuleCategory.traffic,
        ),
        summary: json['summary'] as String,
        fullExplanation: json['fullExplanation'] as String,
        legalBasis: json['legalBasis'] as String,
        penaltyOrRight: json['penaltyOrRight'] as String,
        keyDos: List<String>.from(json['keyDos'] as List),
        keyDonts: List<String>.from(json['keyDonts'] as List),
        keywords: List<String>.from(json['keywords'] as List),
      );
}
