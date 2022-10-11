class UserModel {
  String email;

  UserModel.fromJson(Map<String, dynamic> json) : email = json['email'];
}
