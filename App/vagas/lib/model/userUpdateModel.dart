// import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

class UserUpdate {
  UserUpdate({
    // required this.idUser,
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

  factory UserUpdate.fromJson(Map<String, dynamic> json) {
    return UserUpdate(
      // idUser: json['idUser'],
      email: json['email'],
      token: json['token'],
    );
  }
}
