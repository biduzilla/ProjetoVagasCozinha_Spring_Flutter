class UserAuth {
  UserAuth({
    required this.email,
    required this.token,
  });
  String email;
  String token;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'token': token,
    };
  }

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(email: json['email'], token: json['token']);
  }
}
