import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vagas/auth/page/login.dart';
import 'package:vagas/cv/widget/ButtonWidget.dart';
import 'package:vagas/model/VagaListIdModel.dart';
import 'package:vagas/model/userModel.dart';
import 'package:vagas/model/vagaModel.dart';
import 'package:vagas/vaga/page/vaga.dart';
import 'package:vagas/vaga/widget/CardWidget.dart';

class ExpandandedContainerWidget extends StatefulWidget {
  ExpandandedContainerWidget(
      {Key? key, required this.usuario, required this.empresa})
      : super(key: key);
  final bool empresa;
  final User usuario;

  @override
  State<ExpandandedContainerWidget> createState() =>
      _ExpandandedContainerWidgetState(usuario, empresa);
}

class _ExpandandedContainerWidgetState
    extends State<ExpandandedContainerWidget> {
  final bool empresa;
  List<Vaga> vagas = [];
  final User usuario;
  Vaga? vaga;
  VagaListIdModel? vagasList;
  bool empresaVagas = false;

  void initState() {
    super.initState();
    if (!empresa) {
      for (int id in usuario.vagasAceitas) {
        getVaga(id);
      }
    }
    if (empresa) {
      getListVagasDaEmpresa();
    }
  }

  Future<void> getListVagasDaEmpresa() async {
    var url = Uri.parse("http://10.61.104.110:8081/api/vagas/minhasVagas");
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer ' + usuario.token,
    });

    if (response.statusCode == 200) {
      setState(() {
        vagasList = VagaListIdModel.fromJson(jsonDecode(response.body));
        empresaVagas = true;
      });
      for (int idVaga in vagasList!.vagaId) {
        getMinhaVaga(idVaga);
      }
    } else if (response.statusCode == 404) {
      empresaVagas = false;
    } else {
      alertDialog("Entre novamento na sua conta!", 1);
    }
  }

  Future<void> getMinhaVaga(int idVaga) async {
    var url = Uri.parse(
        'http://10.61.104.110:8081/api/vagas/verMinhasVagas/${idVaga}');
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer ' + usuario.token,
    });

    if (response.statusCode == 200) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      vaga = Vaga.fromJson(jsonDecode(source));
      setState(() {
        vagas.add(vaga!);
      });
    } else {
      alertDialog("Entre novamento na sua conta!", 1);
    }
  }

  Future<void> getVaga(int idVaga) async {
    var url =
        Uri.parse('http://10.61.104.110:8081/api/vagas/verVaga/${idVaga}');
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer ' + usuario.token,
    });

    if (response.statusCode == 200) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      vaga = Vaga.fromJson(jsonDecode(source));
      setState(() {
        vagas.add(vaga!);
      });
    } else {
      alertDialog("Entre novamento na sua conta!", 1);
    }
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

  _ExpandandedContainerWidgetState(
    this.usuario,
    this.empresa,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (vagas.isNotEmpty)
              CardWidget(
                vagas: vagas,
                usuario: usuario,
                empresa: empresa,
              ),
            if (vagas.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sentiment_neutral_rounded,
                          color: Colors.green,
                          size: 80,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          !empresaVagas && !empresa
                              ? "Você ainda não se inscreveu em nenhuma vaga"
                              : "Você ainda não cadastrou nenhuma vaga",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 26,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ButtonWidget(
              press: (() {
                if (usuario.admin) {
                  if (!empresa) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                VagaScreen(usuario: usuario, empresa: true)));
                  } else {
                    print("Cadastrar Vaga");
                  }
                } else if (!empresa) {
                  alertDialog("Acesso Negado", 0);
                }
              }),
              text: !empresa ? "Área da Empresa" : "Cadastrar Vaga",
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
    );
  }
}
