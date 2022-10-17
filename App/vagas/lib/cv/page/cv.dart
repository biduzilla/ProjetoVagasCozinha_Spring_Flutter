import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vagas/auth/page/login.dart';
import 'package:vagas/auth/widget/alert.dart';
import 'package:vagas/cv/widget/multipleTextForm.dart';
import 'package:vagas/cv/widget/textForm.dart';
import 'package:vagas/home/page/homepage.dart';
import 'package:vagas/home/widget/footer.dart';
import 'package:vagas/home/widget/noVagas.dart';
import 'package:vagas/home/widget/vagaList.dart';
import 'package:vagas/model/VagaListIdModel.dart';
import 'package:vagas/model/userAuthModel.dart';
import 'package:vagas/model/vagaModel.dart';
import 'dart:convert';

import '../../../model/userModel.dart';

class CvPageScreen extends StatefulWidget {
  final UserAuth usuario;

  const CvPageScreen({Key? key, required this.usuario}) : super(key: key);

  @override
  State<CvPageScreen> createState() => _CvPageScreenState(usuario);
}

class _CvPageScreenState extends State<CvPageScreen> {
  final UserAuth? usuario;
  List<String> experiencias = [];
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

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => homePageScreen(usuario: usuario!),
        ),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CvPageScreen(usuario: usuario!),
        ),
      );
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
                                  ),
                                  TextFormWidget(
                                    text: "Email",
                                    index: 2,
                                    returnController: returnController,
                                  ),
                                  TextFormWidget(
                                    text: "Telefone",
                                    index: 3,
                                    returnController: returnController,
                                  ),
                                  TextFormWidget(
                                    text: "Sobre",
                                    index: 4,
                                    returnController: returnController,
                                  ),
                                  TextFormWidget(
                                    text: "Semestre",
                                    index: 5,
                                    returnController: returnController,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12, top: 24),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20.0)),
                                      ),
                                      child: Column(
                                        children: [
                                          MultipleTextForm(
                                            title: "Experiências",
                                          ),
                                        ],
                                      ),
                                      // child:
                                    ),
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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.green,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment,
                color: Colors.amber[800],
              ),
              label: 'Currículo',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.store,
                color: Colors.white,
              ),
              label: 'Vagas',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: 'Meus Dados',
            ),
          ],
          currentIndex: 1,
          unselectedItemColor: Colors.white,
          unselectedLabelStyle: TextStyle(color: Colors.white, fontSize: 14),
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void returnControllerExperiencia(String text, int index) {
    String temp = "";
    if (indexString == index - 1) {
      genericText = text;
      print(genericText);
    } else if (indexString < index - 1) {
      temp = genericText!;
      indexString = index - 1;
      experiencias.add(genericText!);
    } else {
      indexString = index - 1;
      experiencias.remove(temp);
    }

    print(experiencias);
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