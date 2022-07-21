// import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

class User {
  User({
    required this.idUser,
    required this.email,
    required this.cv,
  });

  int idUser;
  String email;
  String cv;

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'email': email,
      'cv': cv,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['idUser'],
      email: json['email'],
      cv: json['cv'],
    );
  }
}
