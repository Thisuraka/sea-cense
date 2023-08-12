class CucumberOnProbability {
  String? type;
  String? description;
  String? scientificName;
  String? family;
  String? kingdom;
  String? phylum;
  String? diet;

  CucumberOnProbability({
    this.type,
    this.description,
    this.scientificName,
    this.family,
    this.kingdom,
    this.phylum,
    this.diet,
  });

  CucumberOnProbability.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
    scientificName = json['scientificName'];
    family = json['family'];
    kingdom = json['kingdom'];
    phylum = json['phylum'];
    diet = json['diet'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['description'] = description;
    data['scientificName'] = scientificName;
    data['family'] = family;
    data['kingdom'] = kingdom;
    data['phylum'] = phylum;
    data['diet'] = diet;

    return data;
  }
}
