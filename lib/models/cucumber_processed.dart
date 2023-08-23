class CucumberProcessed {
  String? predictedType;
  String? predictedClass;
  String? predictedProbabilities;

  CucumberProcessed({
    this.predictedType,
    this.predictedClass,
    this.predictedProbabilities,
  });

  CucumberProcessed.fromJson(Map<String, dynamic> json) {
    predictedType = json['predicted_name'];
    predictedClass = json['quality'];
    predictedProbabilities = json['predicted_probabilities'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['predicted_name'] = predictedType;
    data['quality'] = predictedClass;
    data['predicted_probabilities'] = predictedProbabilities;

    return data;
  }
}
