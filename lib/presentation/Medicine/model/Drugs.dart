
class Drug {
  final bool availableEgypt;
  final bool availableSaudi;
  final String classification;
  final String classificationArabic;
  final String company;
  final bool drugSchedules;
  final int parcode;
  final String pharmaceuticalClasses;
  final String photo;
  final int priceInEgypt;
  final int priceInSaudi;
  final int quantity;
  final String routeOfAdministration;
  final String routeOfAdministrationArabic;
  final String activeIngredientUnit;
  final String activeIngredientUnitArabic;
  final List<String> activeIngredients;
  final int activeIngredientStrength;
  final String dosageForm;
  final String dosageFormArabic;
  final String productId;
  final String productNdc;
  final String productName;
  final String productNameArabic;
  final String productType;
  final String productTypeArabic;
  final int? numbersofPeoplewhoAddit;
  final List<String> tomydrugs;

  Drug({
    required this.availableEgypt,
    required this.availableSaudi,
    required this.classification,
    required this.classificationArabic,
    required this.company,
    required this.drugSchedules,
    required this.parcode,
    required this.pharmaceuticalClasses,
    required this.photo,
    required this.priceInEgypt,
    required this.priceInSaudi,
    required this.quantity,
    required this.routeOfAdministration,
    required this.routeOfAdministrationArabic,
    required this.activeIngredientUnit,
    required this.activeIngredientUnitArabic,
    required this.activeIngredients,
    required this.activeIngredientStrength,
    required this.dosageForm,
    required this.dosageFormArabic,
    required this.productId,
    required this.productNdc,
    required this.productName,
    required this.productNameArabic,
    required this.productType,
    required this.productTypeArabic,
    required this.numbersofPeoplewhoAddit,
    required this.tomydrugs,

  });

  factory Drug.fromJson(Map<String, dynamic> json) {
    return Drug(
      availableEgypt: json['AvaliableEgypt'] ?? false,
      availableSaudi: json['AvaliableSaudi'] ?? false,
      classification: json['Classification'] ?? '',
      classificationArabic: json['ClassificationArabic'] ?? '',
      company: json['Company'] ?? '',
      drugSchedules: json['Drug Schedules'] ?? false,
      parcode: (json['Parcode'] is double)
          ? (json['Parcode'] as double).toInt()
          : json['Parcode'] ?? 0,
      pharmaceuticalClasses: json['PharmaceuticalClasses'] ?? '',
      photo: json['Photo'] ?? '',
      priceInEgypt: (json['PriceinEgypt'] is double)
          ? (json['PriceinEgypt'] as double).toInt()
          : json['PriceinEgypt'] ?? 0,
      priceInSaudi: (json['PriceinSaudi'] is double)
          ? (json['PriceinSaudi'] as double).toInt()
          : json['PriceinSaudi'] ?? 0,
      quantity: (json['Quntaity'] is double)
          ? (json['Quntaity'] as double).toInt()
          : json['Quntaity'] ?? 0,
      routeOfAdministration: json['Route of Administration'] ?? '',
      routeOfAdministrationArabic: json['Route of AdministrationArabic'] ?? '',
      activeIngredientUnit: json['activeIngredientUnit'] ?? '',
      activeIngredientUnitArabic: json['activeIngredientUnitArabic'] ?? '',
      activeIngredients: List<String>.from(json['activeIngredients'] ?? []),

      activeIngredientStrength: (json['activeingredientstrength'] is double)
          ? (json['activeingredientstrength'] as double).toInt()
          : json['activeingredientstrength'] ?? 0,
      dosageForm: json['dosageform'] ?? '',
      dosageFormArabic: json['dosageformarabic'] ?? '',
      productId: json['productID'] ?? '',
      productNdc: json['productNDC'] ?? '',
      productName: json['productname'] ?? '',
      productNameArabic: json['productnamearabic'] ?? '',
      productType: json['producttype'] ?? '',
      productTypeArabic: json['producttypearabic'] ?? '',
      numbersofPeoplewhoAddit: json["NumbersofPeoplewhoAddit"] ?? 0,
      tomydrugs: List<String>.from(json['myDrugs'] ?? []),
    );
  }
}
