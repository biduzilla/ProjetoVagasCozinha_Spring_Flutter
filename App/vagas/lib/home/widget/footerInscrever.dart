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
                if (code == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => loginScreen(),
                    ),
                  );
                } else if (code == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => homePageScreen(
                        usuario: userAuth!,
                      ),
                    ),
                  );
                }
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

    print(response.statusCode);
    print(response.body);
    print('http://10.61.104.110:8081/api/aceitar/${vaga!.vagaId}');
    if (response.statusCode == 400) {
      error = ErrorModel.fromJson(jsonDecode(response.body));
      alertDialog("Você já está participando desta vaga!", 0);
    } else if (response.statusCode == 403 || response.statusCode == 401) {
      alertDialog("Entre novamento na sua conta!", 1);
    } else {
      alertDialog("Currículo Enviado!", 0);
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
                print("Editar Vaga");
              } else {
                print("Excluir Vaga");
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
