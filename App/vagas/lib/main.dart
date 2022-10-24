import 'package:flutter/material.dart';
import 'package:vagas/auth/page/signUp.dart';
import 'package:vagas/cv/page/CvMostrar.dart';
import 'package:vagas/cv/page/CvSalvar.dart';
import 'package:vagas/home/page/vaga.dart';
import 'package:vagas/model/userAuthModel.dart';
import 'package:vagas/model/userModel.dart';
import 'package:vagas/model/vagaModel.dart';
import 'package:vagas/vaga/page/vaga.dart';

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
          "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2RkeUB0b2RkeSIsImV4cCI6MTY2NjIwMzExMn0.Nn6hRggDbcM0iqeHTL7Kgv37OjDy-Ow1CDfbrhl3AmOcJcbTFzgYJtv4pMqo1Q9Pg8pfCzZ5tvryvubCFKOQkg",
    );
    User user = User(
        cv: 'CADASTRADO',
        email: 'toddy@toddy',
        token:
            'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2RkeUB0b2RkeSIsImV4cCI6MTY2NjM4MjQ2N30.MCFWN1-UXl9Jdem0pA9D_Fh4PA8fDKeUg6Nk_EUW7zWDBD7UTRC_fiTM18e8P--v1mXBnJ_R1ieA_2_rO8ow_A',
        vagasAceitas: [2, 2]);

    return MaterialApp(
      //
      // home: loginScreen(),

      // home: VagaScreen(
      //   usuario: user,
      // ),

      home: VagaScreen(
        usuario: user,
      ),

      // home: homePageScreen(
      //   usuario: user,
      // ),
      // home: CvPageScreen(
      //   usuario: userAuth,
      // ),

      // home: CvMostrarScreen(
      //   usuario: user,
      // ),

      //
    );
  }
}
