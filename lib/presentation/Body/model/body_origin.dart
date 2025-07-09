class BodyOrigin {
  String anatomicalLocation;
  String anatomicalLocationArabic;
  String causes;
  String causesArabic;
  String description;
  String descriptionArabic;
  String diagnosis;
  String diagnosisArabic;
  String disease;
  String diseaseArabic;
  String firstAid;
  String firstAidArabic;
  String part;
  List<String> preventiveMeasures;
  List<String> preventiveMeasuresArabic;
  String recommendedTreatment;
  String recommendedTreatmentArabic;
  String whenToConsultProfessional;
  String whenToConsultProfessionalArabic;
  List<String> symptoms;
  List<String> symptomsArabic;

  BodyOrigin({
    required this.anatomicalLocation,
    required this.anatomicalLocationArabic,
    required this.causes,
    required this.causesArabic,
    required this.description,
    required this.descriptionArabic,
    required this.diagnosis,
    required this.diagnosisArabic,
    required this.disease,
    required this.diseaseArabic,
    required this.firstAid,
    required this.firstAidArabic,
    required this.part,
    required this.preventiveMeasures,
    required this.preventiveMeasuresArabic,
    required this.recommendedTreatment,
    required this.recommendedTreatmentArabic,
    required this.whenToConsultProfessional,
    required this.whenToConsultProfessionalArabic,
    required this.symptoms,
    required this.symptomsArabic,
  });

  factory BodyOrigin.fromJson(Map<String, dynamic> json) {
    return BodyOrigin(
      anatomicalLocation: json['AnatomicalLocation'],
      anatomicalLocationArabic: json['AnatomicalLocationArabic'],
      causes: json['Causes'],
      causesArabic: json['CausesArabic'],
      description: json['Description'],
      descriptionArabic: json['DescriptionArabic'],
      diagnosis: json['Diagnosis'],
      diagnosisArabic: json['DiagnosisArabic'],
      disease: json['Disease'],
      diseaseArabic: json['DiseaseArabic'],
      firstAid: json['FirstAid'],
      firstAidArabic: json['FirstAidArabic'],
      part: json['FirstAidArabic'],
      preventiveMeasures: List<String>.from(json['PreventiveMeasures']),
      preventiveMeasuresArabic:
      List<String>.from(json['PreventiveMeasuresArabic']),
      recommendedTreatment: json['RecommendedTreatment'],
      recommendedTreatmentArabic: json['RecommendedTreatmentArabic'],
      whenToConsultProfessional: json['WhenToConsultProfessional'],
      whenToConsultProfessionalArabic: json['WhenToConsultProfessionalArabic'],
      symptoms: List<String>.from(json['symptoms']),
      symptomsArabic: List<String>.from(json['symptomsArabic']),
    );
  }
}
