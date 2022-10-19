import 'package:flutter/material.dart';
import 'package:vagas/auth/page/signUp.dart';
import 'package:vagas/cv/page/CvMostrar.dart';
import 'package:vagas/cv/page/CvSalvar.dart';
import 'package:vagas/home/page/vaga.dart';
import 'package:vagas/model/userAuthModel.dart';
import 'package:vagas/model/vagaModel.dart';
import 'package:vagas/test.dart';

import 'auth/page/login.dart';
import 'home/page/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Vaga vagaTeste = Vaga(
      vagaId: 2,
      cargo: "cachorro de oficina",
      descricao: "cuidar da oficina",
      local: "bandera",
      horario: "tarde",
      requisitos: ["correr", "pular"],
      remuneracao: 123.12,
      dataPostada: "01/01/2022",
    );
    UserAuth userAuth = UserAuth(
      email: "toddy@toddy",
      token:
          "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2RkeUB0b2RkeSIsImV4cCI6MTY2NjE5NTM3OX0.ko2hd4ZYMWDO3cj8W1taMQRbCfo2tLmf6VEVHdnIqHyH-wex5lhrxSZn5xdJlYCe6iXlT5hyBaxu29MjezftQQ",
    );
    return MaterialApp(
      // home: loginScreen(),

      // home: vagaScreen(
      //   usuario: userAuth,
      //   vaga: vagaTeste,
      // ),

      // home: homePageScreen(
      //   usuario: userAuth,
      // ),
      // home: CvPageScreen(
      //   usuario: userAuth,
      // ),

      home: CvMostrarScreen(
        usuario: userAuth,
      ),
    );
  }
}
