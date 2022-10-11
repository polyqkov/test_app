class RegModel {
  final String email;
  final String password;

  const RegModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
