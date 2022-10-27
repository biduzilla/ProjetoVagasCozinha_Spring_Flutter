import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vagas/auth/page/login.dart';
import 'package:vagas/auth/widget/alert.dart';
import 'package:vagas/cv/page/CvMostrar.dart';
import 'package:vagas/cv/widget/footer.dart';
import 'package:vagas/cv/widget/multipleTextForm.dart';
import 'package:vagas/cv/widget/ButtonWidget.dart';
import 'package:vagas/cv/widget/textForm.dart';
import 'package:vagas/home/page/homepage.dart';
import 'package:vagas/home/widget/noVagas.dart';
import 'package:vagas/home/widget/vagaList.dart';
import 'package:vagas/model/CvModel.dart';
import 'package:vagas/model/VagaListIdModel.dart';
import 'package:vagas/model/userAuthModel.dart';
import 'package:vagas/model/vagaModel.dart';
import 'dart:convert';

import '../../../model/userModel.dart';

class CvPageScreen extends StatefulWidget {
  User usuario;

  CvPageScreen({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  @override
  State<CvPageScreen> createState() => _CvPageScreenState(
        usuario,
      );
}

class _CvPageScreenState extends State<CvPageScreen> {
  User? usuario;
  List<String> experiencias = [];
  List<String> qualificacoes = [];
  bool flag = false;
  String? genericText;
  int indexString = 0;
  String? nome;
  String? email;
  String? telefone;
  String? sobre;
  String? semestre;

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
                        usuario: usuario!,
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

  Future<void> getUserDados() async {
    String token;
    var url = Uri.parse('http://10.61.104.110:8081/api/users/getDados');

    var response = await http.get(url, headers: {
      'Authorization': 'Bearer ' + usuario!.token,
    });

    if (response.statusCode == 200) {
      usuario = User.fromJson(jsonDecode(response.body));
      usuario!.token = usuario!.token;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => homePageScreen(
            usuario: usuario!,
          ),
        ),
      );
    }
  }

  void getTextList(List<String> lst, int code) {
    if (code == 0) {
      experiencias = lst;
    } else {
      qualificacoes = lst;
    }
  }

  void removeTextList(String txt, int code) {
    if (code == 0) {
      experiencias.remove(txt);
    } else {
      qualificacoes.remove(txt);
    }
  }

  void montarCv() {
    if (nome == null || email == null || sobre == null || semestre == null) {
      alertDialog("Preencha os dados!", 1);
    } else if (usuario!.cv == "NAO_CADASTRADO") {
      salvarCv();
    } else if (usuario!.cv == "CADASTRADO") {
      atualizarCv();
      alertDialog("Curriculo Atualizado", 0);
    }
  }

  Future<void> salvarCv() async {
    var url = Uri.parse('http://10.61.104.110:8081/api/curriculum/salvarCv');
    Map data = {
      "nome": email,
      "emailContatoCV": email,
      "telefone": telefone,
      "sobre": sobre,
      "semestre": semestre,
      "experiencias": experiencias,
      "qualificacoes": qualificacoes,
    };

    var body = json.encode(data);
    print(body);

    var response = await http.post(url,
        headers: {
          'Authorization': 'Bearer ' + usuario!.token,
          'Content-Type': 'application/json',
        },
        body: body);

    if (response.statusCode == 201) {
      getUserDados();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => homePageScreen(
            usuario: usuario!,
          ),
        ),
      );
    } else {
      alertDialog("Codigo Error:" + response.statusCode.toString(), 0);
    }
  }

  Future<void> atualizarCv() async {
    var url = Uri.parse('http://10.61.104.110:8081/api/curriculum/updateCv');
    Map data = {
      "nome": nome,
      "emailContatoCV": email,
      "telefone": telefone,
      "sobre": sobre,
      "semestre": semestre,
      "experiencias": experiencias,
      "qualificacoes": qualificacoes,
    };

    var body = json.encode(data);

    var response = await http.put(url,
        headers: {
          'Authorization': 'Bearer ' + usuario!.token,
          'Content-Type': 'application/json',
        },
        body: body);

    if (response.statusCode != 204) {
      alertDialog("Codigo Error:" + response.statusCode.toString(), 0);
    }
  }

  _CvPageScreenState(this.usuario);
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
                    usuario!.email,
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
                                    text: "Nome",
                                    index: 1,
                                    returnController: returnController,
                                    isNumber: false,
                                  ),
                                  TextFormWidget(
                                    text: "Email",
                                    index: 2,
                                    returnController: returnController,
                                    isNumber: false,
                                  ),
                                  TextFormWidget(
                                    text: "Telefone",
                                    index: 3,
                                    returnController: returnController,
                                    isNumber: false,
                                  ),
                                  TextFormWidget(
                                    text: "Sobre",
                                    index: 4,
                                    returnController: returnController,
                                    isNumber: false,
                                  ),
                                  TextFormWidget(
                                    text: "Semestre",
                                    index: 5,
                                    returnController: returnController,
                                    isNumber: true,
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
                                            title: "Experiências",
                                            hint: "Minhas Experiências",
                                            getTextList: getTextList,
                                            removeTextList: removeTextList,
                                          ),
                                          MultipleTextForm(
                                            code: 1,
                                            title: "Qualificações",
                                            hint: "Minhas Qualificações",
                                            getTextList: getTextList,
                                            removeTextList: removeTextList,
                                          ),
                                        ],
                                      ),
                                      // child:
                                    ),
                                  ),
                                  ButtonWidget(
                                    press: montarCv,
                                    text: usuario!.cv != "CADASTRADO"
                                        ? 'Salvar Currículo'
                                        : 'Atualizar Currículo',
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
        bottomNavigationBar: FooterWidget(usuario: usuario!, page: 1),
      ),
    );
  }

  void returnController(String text, int index) {
    switch (index) {
      case 1:
        nome = text;
        break;
      case 2:
        email = text;
        break;
      case 3:
        telefone = text;
        break;
      case 4:
        sobre = text;
        break;
      case 5:
        semestre = text;
        break;
      default:
    }
  }
}
