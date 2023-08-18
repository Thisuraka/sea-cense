class CucumberProcessed {
  String? predictedClass;
  String? predictedProbabilities;

  CucumberProcessed({
    this.predictedClass,
    this.predictedProbabilities,
  });

  CucumberProcessed.fromJson(Map<String, dynamic> json) {
    predictedClass = json['predicted_class'];
    predictedProbabilities = json['predicted_probabilities'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['predicted_class'] = predictedClass;
    data['predicted_probabilities'] = predictedProbabilities;

    return data;
  }
}
