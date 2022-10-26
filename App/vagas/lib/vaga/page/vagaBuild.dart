import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vagas/auth/page/login.dart';
import 'package:vagas/cv/widget/ButtonWidget.dart';
import 'package:vagas/cv/widget/footer.dart';
import 'package:vagas/cv/widget/multipleTextForm.dart';
import 'package:vagas/cv/widget/textForm.dart';
import 'package:vagas/home/page/homepage.dart';
import 'package:vagas/model/userModel.dart';

class VagaBuildScreen extends StatefulWidget {
  const VagaBuildScreen(
      {Key? key, required this.usuario, required this.isSalvarVaga})
      : super(key: key);
  final User usuario;
  final bool isSalvarVaga;
  @override
  State<VagaBuildScreen> createState() =>
      _VagaBuildScreenState(usuario, isSalvarVaga);
}

class _VagaBuildScreenState extends State<VagaBuildScreen> {
  final User usuario;
  final bool isSalvarVaga;

  String? cargo;
  String? descricao;
  String? local;
  String? horario;
  double? remuneracao;
  List<String>? requisitos;

  _VagaBuildScreenState(this.usuario, this.isSalvarVaga);

  void getTextList(List<String> lst, int code) {
    requisitos = lst;
  }

  void removeTextList(String txt, int code) {
    requisitos!.remove(txt);
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
                } else if (code == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => homePageScreen(
                        usuario: usuario,
                      ),
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

  void returnController(var text, int index) {
    print(text);
    switch (index) {
      case 1:
        cargo = text;
        break;
      case 2:
        descricao = text;
        break;
      case 3:
        local = text;
        break;
      case 4:
        horario = text;
        break;
      case 5:
        remuneracao = double.parse(text);
        break;
      default:
    }
  }

  Future<void> cadastrarVaga() async {
    var url = Uri.parse('http://10.61.104.110:8081/api/vagas/cadastrar');
    Map data = {
      "cargo": cargo,
      "descricao": descricao,
      "local": local,
      "horario": horario,
      "requisitos": requisitos,
      "remuneracao": remuneracao,
    };

    var body = json.encode(data);

    var response = await http.post(url,
        headers: {
          'Authorization': 'Bearer ' + usuario.token,
          'Content-Type': 'application/json',
        },
        body: body);

    if (response.statusCode != 201 || response.statusCode != 403) {
      alertDialog("Error ao cadastrar vaga", 0);
      print(response.body);
    } else if (response.statusCode == 201) {
      alertDialog("Vaga Cadastrada", 0);
    }
  }

  void montarVaga() {
    if (cargo == null ||
        descricao == null ||
        local == null ||
        horario == null ||
        remuneracao == null) {
      alertDialog("Preencha os dados!", 0);
    } else {
      cadastrarVaga();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
                    Expanded(
                      child: ListView(
                        reverse: false,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormWidget(
                                    text: "Cargo",
                                    index: 1,
                                    returnController: returnController,
                                    num: false,
                                  ),
                                  TextFormWidget(
                                    text: "Descrição",
                                    index: 2,
                                    returnController: returnController,
                                    num: false,
                                  ),
                                  TextFormWidget(
                                    text: "Local",
                                    index: 3,
                                    returnController: returnController,
                                    num: false,
                                  ),
                                  TextFormWidget(
                                    text: "Horario",
                                    index: 4,
                                    returnController: returnController,
                                    num: false,
                                  ),
                                  TextFormWidget(
                                    text: "Remuneração",
                                    index: 5,
                                    returnController: returnController,
                                    num: true,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 24),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20.0),
                                          bottom: Radius.circular(20.0),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          MultipleTextForm(
                                            code: 0,
                                            title: "Requisitos",
                                            hint: "Requisitos para vaga",
                                            getTextList: getTextList,
                                            removeTextList: removeTextList,
                                          ),
                                        ],
                                      ),
                                      // child:
                                    ),
                                  ),
                                  ButtonWidget(
                                    press: montarVaga,
                                    text: isSalvarVaga
                                        ? 'Cadastrar Vaga'
                                        : 'Atualizar Vaga',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
        bottomNavigationBar: FooterWidget(usuario: usuario, page: 2),
      ),
    );
  }
}
