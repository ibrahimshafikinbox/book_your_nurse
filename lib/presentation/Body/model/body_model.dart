class Body {
  String name;
  String picture;
  int id;

  Body({
    required this.name,
    required this.picture,
    required this.id,
  });

  factory Body.fromJson(Map<String, dynamic> json) {
    return Body(
      name: json['Name'],
      picture: json['Picture'],
      id: json['id'],
    );
  }
}
