class CucumberJuvenile {
  String? type;
  String? weight;
  String? initSize;
  String? growthRate;
  String? survivalRate;
  String? totalBiomass;

  CucumberJuvenile({
    this.type,
    this.weight,
    this.initSize,
    this.growthRate,
    this.survivalRate,
    this.totalBiomass,
  });

  CucumberJuvenile.fromJson(Map<String, dynamic> json) {
    type = json['class'];
    weight = json['finalWeight'];
    initSize = json['initSizeGroup'];
    growthRate = json['growthRatePerDay'];
    survivalRate = json['survivalRate'];
    totalBiomass = json['totalBioMass'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class'] = type;
    data['finalWeight'] = weight;
    data['initSizeGroup'] = initSize;
    data['growthRatePerDay'] = growthRate;
    data['survivalRate'] = survivalRate;
    data['totalBioMass'] = totalBiomass;

    return data;
  }
}
