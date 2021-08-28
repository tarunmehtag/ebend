class UserModel {
  String name = '';
  String id = '';
  String uid = '';
  String email = '';
  String dob = '';

  UserModel({this.name = '', this.id = '', this.uid = '', this.email = '', this.dob = ''});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    id = json['id'] ?? "";
    uid = json['uid'] ?? "";
    email = json['email'] ?? "";
    dob = json['dob'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['email'] = this.email;
    data['dob'] = this.dob;
    return data;
  }
}