import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:vagas/auth/page/login.dart';
import 'package:vagas/cv/widget/ButtonWidget.dart';
import 'package:vagas/cv/widget/footer.dart';
import 'package:vagas/model/userModel.dart';
import 'package:vagas/model/vagaModel.dart';
import 'package:vagas/vaga/widget/expandedContainer.dart';
import 'package:http/http.dart' as http;

class VagaScreen extends StatefulWidget {
  const VagaScreen({Key? key, required this.usuario}) : super(key: key);
  final User usuario;

  @override
  State<VagaScreen> createState() => _VagaScreenState(usuario);
}

class _VagaScreenState extends State<VagaScreen> {
  final User usuario;
  Vaga? vaga;
  List<Vaga> vagas = [];

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

  Future<void> getVaga(int idVaga) async {
    var url = Uri.parse('http://10.61.104.110:8081/api/vagas/${idVaga}');
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer ' + usuario.token,
    });

    if (response.statusCode == 403) {
      alertDialog("Entre novamento na sua conta!", 1);
    } else {
      setState(() {
        String source = Utf8Decoder().convert(response.bodyBytes);
        vaga = Vaga.fromJson(jsonDecode(source));
        setState(() {
          vagas.add(vaga!);
        });
      });
    }
  }

  void initState() {
    super.initState();
    setState(() {
      for (int id in usuario.vagasAceitas) {
        getVaga(id);
      }
    });
  }

  _VagaScreenState(this.usuario);
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
          if (vagas.isNotEmpty)
            ExpandandedContainerWidget(
              vagas: vagas,
              usuario: usuario,
            ),
        ],
      ),
      bottomNavigationBar: FooterWidget(usuario: usuario, page: 2),
    );
  }
}
