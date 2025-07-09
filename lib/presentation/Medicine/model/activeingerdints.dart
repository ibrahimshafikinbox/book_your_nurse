class ActiveIngredients {
  final String drugClass;
  final String subclass;
  final String drug;
  final String mechanism;
  final String pharmacokinetics;
  final String clinicalUse;
  final String clinicalUseAR;
  final String sideEffects;
  final String sideEffectsAR;
  final String contraindication;
  final String drugInteraction;
  final String doses;
  final String dosesAR;

  ActiveIngredients({
    required this.drugClass,
    required this.subclass,
    required this.drug,
    required this.mechanism,
    required this.pharmacokinetics,
    required this.clinicalUse,
    required this.clinicalUseAR,
    required this.sideEffects,
    required this.sideEffectsAR,
    required this.contraindication,
    required this.drugInteraction,
    required this.doses,
    required this.dosesAR,
  });

  factory ActiveIngredients.fromJson(Map<String, dynamic> json) {
    return ActiveIngredients(
      drugClass: json['Class'] ?? '',
      subclass: json['Subcalss'] ?? '',
      drug: json['Drug'] ?? '',
      mechanism: json['Mechanism'] ?? '',
      pharmacokinetics: json['Pharmacokinetics'] ?? '',
      clinicalUse: json['Clinical_Use'] ?? '',
      clinicalUseAR: json['Clinical_Use_AR'] ?? '',
      sideEffects: json['Side_Effects'] ?? '',
      sideEffectsAR: json['Side_Effects_AR'] ?? '',
      contraindication: json['Contraindication'] ?? '',
      drugInteraction: json['Drug_Interaction'] ?? '',
      doses: json['Doses'] ?? '',
      dosesAR: json['Doses_AR'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Class': drugClass,
      'Subcalss': subclass,
      'Drug': drug,
      'Mechanism': mechanism,
      'Pharmacokinetics': pharmacokinetics,
      'Clinical_Use': clinicalUse,
      'Clinical_Use_AR': clinicalUseAR,
      'Side_Effects': sideEffects,
      'Side_Effects_AR': sideEffectsAR,
      'Contraindication': contraindication,
      'Drug_Interaction': drugInteraction,
      'Doses': doses,
      'Doses_AR': dosesAR,
    };
  }
}
