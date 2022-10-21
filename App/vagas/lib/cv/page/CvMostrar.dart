import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vagas/auth/page/login.dart';
import 'package:vagas/cv/widget/CardDados.dart';
import 'package:vagas/cv/widget/footer.dart';
import 'package:vagas/model/CvModel.dart';
import 'package:vagas/model/userAuthModel.dart';
import 'package:vagas/model/userModel.dart';

class CvMostrarScreen extends StatefulWidget {
  CvMostrarScreen({Key? key, required this.usuario}) : super(key: key);
  final User usuario;
  @override
  State<CvMostrarScreen> createState() => _CvMostrarScreenState(usuario);
}

class _CvMostrarScreenState extends State<CvMostrarScreen> {
  final User usuario;
  CvModel? cv;
  bool flag = false;

  _CvMostrarScreenState(this.usuario);

  void initState() {
    super.initState();
    setState(() {
      getCv();
    });
  }

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
                } else {
                  Navigator.pop(context);
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

  Future<void> getCv() async {
    var url = Uri.parse('http://10.61.104.110:8081/api/curriculum/getCv');

    var response = await http.get(url, headers: {
      'Authorization': 'Bearer ' + usuario.token,
      "Content-Type": "application/json; charset=UTF-8",
    });

    if (response.statusCode == 200) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      cv = CvModel.fromJson(jsonDecode(source));
      setState(() {
        flag = true;
      });
    } else if (response.statusCode == 403) {
      alertDialog("Expirada a Sessão", 1);
    } else if (response.statusCode == 401) {
      alertDialog("Expirada a Sessão", 1);
    } else {
      alertDialog("Erro Carregamento Cv", 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 28,
                ),
                Text(
                  usuario.email,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (flag)
                    CardDadosWidget(
                      cv: cv!,
                      usuario: usuario,
                    )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FooterWidget(usuario: usuario, page: 1),
    );
  }
}
