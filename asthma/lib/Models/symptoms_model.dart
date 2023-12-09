class SymptomsModel {
  int? symptomID;
  int? userID;
  String? symptomName;
  String? symptomIntensity;
  String? symptomDetails;

  SymptomsModel({
     this.symptomID,
    this.userID,
    this.symptomName,
    this.symptomIntensity,
    this.symptomDetails,
  });

  SymptomsModel.fromJson(Map<String, dynamic> json) {
    symptomID = json['id'];
    userID = json['user_id'];
    symptomName = json['symptom_name'];
    symptomIntensity = json['intensity'];
    symptomDetails = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = symptomID;
    data['symptom_name'] = symptomName;
    data['description'] = symptomDetails;
    data['intensity'] = symptomIntensity;
    data['user_id'] = userID;

    return data;
  }
}
