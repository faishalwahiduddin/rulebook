import 'rule_category.dart';

class SopStep {
  final int stepNumber;
  final String title;
  final String detail;
  final String? warning;
  final String? practicalTip;

  const SopStep({
    required this.stepNumber,
    required this.title,
    required this.detail,
    this.warning,
    this.practicalTip,
  });

  Map<String, dynamic> toJson() => {
        'stepNumber': stepNumber,
        'title': title,
        'detail': detail,
        'warning': warning,
        'practicalTip': practicalTip,
      };

  factory SopStep.fromJson(Map<String, dynamic> json) => SopStep(
        stepNumber: json['stepNumber'] as int,
        title: json['title'] as String,
        detail: json['detail'] as String,
        warning: json['warning'] as String?,
        practicalTip: json['practicalTip'] as String?,
      );
}

class EmergencyContact {
  final String name;
  final String contactNumber;
  final String note;

  const EmergencyContact({
    required this.name,
    required this.contactNumber,
    required this.note,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'contactNumber': contactNumber,
        'note': note,
      };

  factory EmergencyContact.fromJson(Map<String, dynamic> json) => EmergencyContact(
        name: json['name'] as String,
        contactNumber: json['contactNumber'] as String,
        note: json['note'] as String,
      );
}

class SopGuide {
  final String id;
  final String title;
  final RuleCategory category;
  final String targetScenario;
  final String legalBasis;
  final List<SopStep> steps;
  final List<String> rightsSummary;
  final List<EmergencyContact> emergencyContacts;

  const SopGuide({
    required this.id,
    required this.title,
    required this.category,
    required this.targetScenario,
    required this.legalBasis,
    required this.steps,
    required this.rightsSummary,
    required this.emergencyContacts,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category.name,
        'targetScenario': targetScenario,
        'legalBasis': legalBasis,
        'steps': steps.map((s) => s.toJson()).toList(),
        'rightsSummary': rightsSummary,
        'emergencyContacts': emergencyContacts.map((c) => c.toJson()).toList(),
      };

  factory SopGuide.fromJson(Map<String, dynamic> json) => SopGuide(
        id: json['id'] as String,
        title: json['title'] as String,
        category: RuleCategory.values.firstWhere(
          (c) => c.name == json['category'],
          orElse: () => RuleCategory.traffic,
        ),
        targetScenario: json['targetScenario'] as String,
        legalBasis: json['legalBasis'] as String,
        steps: (json['steps'] as List)
            .map((s) => SopStep.fromJson(s as Map<String, dynamic>))
            .toList(),
        rightsSummary: List<String>.from(json['rightsSummary'] as List),
        emergencyContacts: (json['emergencyContacts'] as List)
            .map((c) => EmergencyContact.fromJson(c as Map<String, dynamic>))
            .toList(),
      );
}
