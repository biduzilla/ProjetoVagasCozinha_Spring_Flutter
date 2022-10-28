import 'package:flutter/material.dart';
import 'package:vagas/auth/page/signUp.dart';
import 'package:vagas/cv/page/CvMostrar.dart';
import 'package:vagas/cv/page/CvSalvar.dart';
import 'package:vagas/home/page/vaga.dart';
import 'package:vagas/model/userAuthModel.dart';
import 'package:vagas/model/userModel.dart';
import 'package:vagas/model/vagaModel.dart';
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
          'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2RkeUB0b2RkeSIsImV4cCI6MTY2Njg5MTg2NH0.-jQgID_Pp50C_xf9kTi1CoRSZQn9FafCvma0JT3t6FkZSXXosoaqUBCe-t_HEBZ4cL2EPv4CpgCd-YZe-WiamQ',
      vagasAceitas: [2, 2, 3],
      admin: true,
    );

    return MaterialApp(
      //
      // home: loginScreen(),

      //     home: VagaBuildScreen(
      //   isSalvarVaga: true,
      //   usuario: user,
      // )

      home: VagaScreen(
        usuario: user,
        empresa: true,
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
