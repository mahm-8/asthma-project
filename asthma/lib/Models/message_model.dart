class MessageModel {
  int? id;
  String? createdAt;
  String? contents;
  String? idFrom;
  String? idTo;
  bool? isMain;

  MessageModel(
      {this.id, this.createdAt, this.contents, this.idFrom, this.idTo});

  MessageModel.fromJson(Map<String, dynamic> json, String currentUserId) {
    id = json['id'];
    createdAt = json['created_at'];
    contents = json['contents'];
    idFrom = json['id_from'];
    idTo = json['id_to'];
    isMain = json['id_from'] == currentUserId;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contents'] = contents;
    data['id_from'] = idFrom;
    data['id_to'] = idTo;
    return data;
  }
}
