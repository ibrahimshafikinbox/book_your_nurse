class NurseService {
  final String nameAr;
  final String nameEn;
  final int price;

  NurseService({
    required this.nameAr,
    required this.nameEn,
    required this.price,
  });

  factory NurseService.fromJson(Map<String, dynamic> json) {
    return NurseService(
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
      'price': price,
    };
  }
}