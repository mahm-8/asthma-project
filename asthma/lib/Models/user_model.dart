class UserModel {
  int? id;
  String? email;
  String? age;
  String? dob;
  String? gender;
  String? phone;
  String? image;
  String? idAuth;
  String? name;
  String? imageCapture;

  UserModel(
      {this.id,
      this.email,
      this.age,
      this.dob,
      this.gender,
      this.phone,
      this.image,
      this.idAuth,
      this.name,
      this.imageCapture});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'] ?? "";
    age = json['age'] ?? "";
    dob = json['dob'] ?? "";
    gender = json['gender'] ?? "";
    phone = json['phone'] ?? "";
    image = json['image'] ?? "";
    idAuth = json['id_auth'] ?? "";
    name = json['name'] ?? "";
    imageCapture = json['image_capture'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['id_auth'] = idAuth;
    return data;
  }
}
