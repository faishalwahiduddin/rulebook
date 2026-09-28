import 'rule_category.dart';

class ChecklistItem {
  final String id;
  final String title;
  final String description;
  final String legalBasis;
  final bool isCrucial;

  const ChecklistItem({
    required this.id,
    required this.title,
    required this.description,
    required this.legalBasis,
    this.isCrucial = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'legalBasis': legalBasis,
        'isCrucial': isCrucial,
      };

  factory ChecklistItem.fromJson(Map<String, dynamic> json) => ChecklistItem(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        legalBasis: json['legalBasis'] as String,
        isCrucial: json['isCrucial'] as bool? ?? false,
      );
}

class ComplianceChecklist {
  final String id;
  final String title;
  final RuleCategory category;
  final String targetAudience;
  final String description;
  final List<ChecklistItem> items;

  const ComplianceChecklist({
    required this.id,
    required this.title,
    required this.category,
    required this.targetAudience,
    required this.description,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category.name,
        'targetAudience': targetAudience,
        'description': description,
        'items': items.map((i) => i.toJson()).toList(),
      };

  factory ComplianceChecklist.fromJson(Map<String, dynamic> json) => ComplianceChecklist(
        id: json['id'] as String,
        title: json['title'] as String,
        category: RuleCategory.values.firstWhere(
          (c) => c.name == json['category'],
          orElse: () => RuleCategory.traffic,
        ),
        targetAudience: json['targetAudience'] as String,
        description: json['description'] as String,
        items: (json['items'] as List)
            .map((i) => ChecklistItem.fromJson(i as Map<String, dynamic>))
            .toList(),
      );
}
