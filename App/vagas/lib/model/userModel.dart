// import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

class User {
  User({
    // required this.idUser,
    required this.email,
    required this.cv,
    required this.token,
    required this.vagasAceitas,
  });

  // int idUser;
  String email;
  String cv;
  String token;
  List<dynamic> vagasAceitas;

  Map<String, dynamic> toJson() {
    return {
      // 'idUser': idUser,
      'email': email,
      'cv': cv,
      'token': token,
      'vagasAceitas': vagasAceitas,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // idUser: json['idUser'],
      email: json['email'],
      cv: json['cv'],
      token: '',
      vagasAceitas: json['vagasAceitas'],
    );
  }
}
