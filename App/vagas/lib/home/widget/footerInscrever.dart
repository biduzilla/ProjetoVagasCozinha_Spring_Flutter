import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vagas/auth/page/login.dart';
import 'package:vagas/auth/widget/alert.dart';
import 'package:vagas/model/ErrorModel.dart';
import 'package:vagas/model/vagaModel.dart';

class FooterInscrever extends StatefulWidget {
  FooterInscrever({Key? key, required this.vaga}) : super(key: key);
  final Vaga vaga;

  @override
  State<FooterInscrever> createState() => _FooterInscrever(vaga);
}

class _FooterInscrever extends State<FooterInscrever> {
  final Vaga? vaga;
  ErrorModel? error;

  _FooterInscrever(this.vaga);

  Future<void> getVaga(String token) async {
    var url =
        Uri.parse('http://10.61.104.110:8081/api/aceitar/${vaga!.vagaId}');
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer ' + token,
    });

    if (response.statusCode != 201 && response.statusCode != 403) {
      error = ErrorModel.fromJson(jsonDecode(response.body));
      alertSpam(text: error!.error.toString());

      if (response.statusCode == 403) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => loginScreen(),
          ),
        );
      }
    } else {
      alertSpam(text: "Currículo Enviado!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: Padding(
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.height / 50,
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 100),
              child: Text(
                "Inscrever",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
