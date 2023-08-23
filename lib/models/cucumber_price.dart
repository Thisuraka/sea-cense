class CucumberPrice {
  String? category;
  String? price;
  String? length;
  String? width;

  CucumberPrice({
    this.category,
    this.price,
    this.length,
    this.width,
  });

  CucumberPrice.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    price = json['price'];
    length = json['length'];
    width = json['width'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['price'] = price;
    data['length'] = length;
    data['width'] = width;

    return data;
  }
}
