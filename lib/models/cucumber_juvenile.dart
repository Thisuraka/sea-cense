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
    type = json['Class'];
    weight = json['Final Weight\n(g)'];
    initSize = json['Initial Size \nGroup'];
    growthRate = json['Specific Growth Rate (% per day)'];
    survivalRate = json['Survival \nRate (%)'];
    totalBiomass = json['Total  Biomass (g)'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['weight'] = weight;
    data['initSize'] = initSize;
    data['growthRate'] = growthRate;
    data['survivalRate'] = survivalRate;
    data['totalBiomass'] = totalBiomass;

    return data;
  }
}
