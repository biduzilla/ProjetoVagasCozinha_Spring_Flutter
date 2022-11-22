import 'package:flutter/material.dart';
import 'package:vagas/auth/page/signUp.dart';
import 'package:vagas/cv/page/CvMostrar.dart';
import 'package:vagas/cv/page/CvSalvar.dart';
import 'package:vagas/home/page/vaga.dart';
import 'package:vagas/meuDados/page/meuDados.dart';
import 'package:vagas/model/CvModel.dart';
import 'package:vagas/model/userAuthModel.dart';
import 'package:vagas/model/userModel.dart';
import 'package:vagas/model/vagaModel.dart';
import 'package:vagas/vaga/page/CvDetails.dart';
import 'package:vagas/vaga/page/vaga.dart';
import 'package:vagas/vaga/page/vagaBuild.dart';

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
    UserAuth userAuth = UserAuth(
      email: "toddy@toddy",
      token:
          "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0aWNvQHRpY28iLCJleHAiOjE2NjY2MzY0MDJ9.D7lbMkA7c_463m6Ee5I7fKqoJg9wfTA43pq5fEbx8GWXH1GD6xAtX1oaEjtluIEO4tqmB5uuRTXw42Rw2GvrBw",
    );
    User user = User(
      cv: 'CADASTRADO',
      email: 'toddy@toddy',
      token:
          'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2RkeUB0b2RkeXkiLCJleHAiOjE2NjkxNTEwNzh9.qyT4bUdRfHZUJcVNo-qR70f5CbwC1rMWGtL-1_4E9_xSL_1BmG42ZS36j8qXGtq6RMegpRHJb93036P2E77SoA',
      vagasAceitas: [3],
      admin: true,
    );

    CvModel cvModel = CvModel(
        emailContatoCV: 'teste@teste.com',
        experiencias: ['teste', 'teste'],
        nome: 'teste',
        qualificacoes: ['teste', 'teste'],
        semestre: 'teste',
        sobre: 'teste',
        telefone: 'teste');

    return MaterialApp(
      //
      // home: loginScreen(),

      home: MeusDadosScreen(
        usuario: user,
      ),

      //     home: VagaBuildScreen(
      //   isSalvarVaga: true,
      //   usuario: user,
      // )

      // home: VagaScreen(
      //   usuario: user,
      //   empresa: true,
      // ),
      // home: CvDetailsScreen(cv: cvModel),

      // home: homePageScreen(
      //   usuario: user,
      // ),
      // home: CvPageScreen(
      //   usuario: userAuth,
      // ),

      // home: CvMostrarScreen(
      //   usuario: user,
      // ),

      // home: AreaEmpresaScreen(
      //   usuario: user,
      // ),

      //     home: VagaBuildScreen(
      //   isSalvarVaga: true,
      //   usuario: user,
      // )

      //
    );
  }
}
