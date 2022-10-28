import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vagas/auth/page/login.dart';
import 'package:vagas/auth/widget/alert.dart';
import 'package:vagas/home/page/homepage.dart';
import 'package:vagas/model/ErrorModel.dart';
import 'package:vagas/model/userAuthModel.dart';
import 'package:vagas/model/userModel.dart';
import 'package:vagas/model/vagaModel.dart';
import 'package:vagas/vaga/page/vaga.dart';
import 'package:vagas/vaga/page/vagaBuild.dart';

class FooterInscrever extends StatefulWidget {
  FooterInscrever(
      {Key? key,
      required this.vaga,
      this.userAuth,
      required this.empresa,
      required this.txt})
      : super(key: key);
  final Vaga vaga;
  final User? userAuth;
  final bool empresa;
  final String txt;

  @override
  State<FooterInscrever> createState() =>
      _FooterInscrever(vaga, userAuth, empresa, txt);
}

class _FooterInscrever extends State<FooterInscrever> {
  final Vaga? vaga;
  ErrorModel? error;
  final User? userAuth;
  final bool empresa;
  final String txt;

  _FooterInscrever(this.vaga, this.userAuth, this.empresa, this.txt);

  Future alertDialog(String text, int code) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              child: Text(
                "OK",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                switch (code) {
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => loginScreen(),
                      ),
                    );
                    break;
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => homePageScreen(
                          usuario: userAuth!,
                        ),
                      ),
                    );
                    break;
                  case 2:
                    deleteVaga();
                    break;
                  default:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VagaScreen(
                          usuario: userAuth!,
                          empresa: userAuth!.admin,
                        ),
                      ),
                    );
                }
                if (code == 1) {
                } else if (code == 0) {}
              },
            ),
          ],
          title: Text("Alerta!",
              style: TextStyle(fontSize: 28, color: Colors.black)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                child: Text(
                  //'Please rate with star',
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> aceitarVaga() async {
    var url = Uri.parse(
        'http://10.61.104.110:8081/api/vagas/aceitar/${vaga!.vagaId}');
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer ' + userAuth!.token,
    });

    if (response.statusCode == 400) {
      error = ErrorModel.fromJson(jsonDecode(response.body));
      alertDialog("Você já está participando desta vaga!", 0);
    } else if (response.statusCode == 403 || response.statusCode == 401) {
      alertDialog("Entre novamento na sua conta!", 1);
    } else if (response.statusCode == 404) {
      alertDialog("Cadastre um currículo primeiro!", 0);
    } else {
      alertDialog("Currículo Enviado!", 0);
    }
  }

  Future<void> deleteVaga() async {
    var url = Uri.parse(
        'http://10.61.104.110:8081/api/vagas/deletarVaga/${vaga!.vagaId}');
    var response = await http.delete(url, headers: {
      'Authorization': 'Bearer ' + userAuth!.token,
    });

    if (response.statusCode == 204) {
      alertDialog("Vaga Apagada", 3);
    } else {
      alertDialog("Entre novamento na sua conta!", 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      height: MediaQuery.of(context).size.height / 10.5,
      child: Center(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              if (!empresa) {
                aceitarVaga();
              } else if (empresa && txt == "Editar Vaga") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VagaBuildScreen(
                      usuario: userAuth!,
                      isSalvarVaga: false,
                      vaga: vaga,
                    ),
                  ),
                );
              } else {
                alertDialog("Você tem certeza que quer excluir essa vaga?", 2);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 100),
              child: Text(
                txt,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: empresa ? 20 : 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
