class MedicationModel {
  int? medicationID;
  String? medicationName;
  int? days;
  String? date;
  int? userID;

  MedicationModel(
      {this.medicationID,
      this.medicationName,
      this.days,
      this.date,
      this.userID});

  MedicationModel.fromJson(Map<String, dynamic> json) {
    medicationID = json['id'];
    medicationName = json['name'];
    days = json['days'];
    date = json['date'];
    userID = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = medicationID;
    data['name'] = medicationName;
    data['days'] = days;
    data['date'] = date;
    data['user_id'] = userID;

    return data;
  }
}
