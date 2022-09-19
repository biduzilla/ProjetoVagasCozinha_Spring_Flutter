import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vagas/auth/page/login.dart';
import 'package:vagas/auth/widget/alert.dart';
import 'package:vagas/home/page/homepage.dart';
import 'package:vagas/home/widget/footer.dart';
import 'package:vagas/home/widget/noVagas.dart';
import 'package:vagas/home/widget/vagaList.dart';
import 'package:vagas/model/VagaListIdModel.dart';
import 'package:vagas/model/userAuthModel.dart';
import 'package:vagas/model/vagaModel.dart';
import 'dart:convert';

import '../../model/userModel.dart';

class CvPageScreen extends StatefulWidget {
  final UserAuth usuario;

  const CvPageScreen({Key? key, required this.usuario}) : super(key: key);

  @override
  State<CvPageScreen> createState() => _CvPageScreenState(usuario);
}

class _CvPageScreenState extends State<CvPageScreen> {
  final UserAuth? usuario;
  final _formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();
  TextEditingController emailContatoCVController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController sobreController = TextEditingController();
  TextEditingController semestreController = TextEditingController();
  List<TextEditingController> experienciasControllers = [];
  List<TextEditingController> qualificacoesControllers = [];
  List<String> experiencias = [];
  List<String> qualificacoes = [];
  int experienciasAdd = 0;
  int qualificacoesAdd = 0;
  int index = 0;
  var temp = "";

  Widget TextFormFild(String text, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
      child: TextFormField(
        style: TextStyle(
          color: Colors.green,
          fontSize: 20,
        ),
        cursorColor: Colors.green,
        controller: controller,
        maxLines: null,
        autofocus: false,
        decoration: InputDecoration(
          filled: true,
          // fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: text,
          labelStyle: TextStyle(
            fontSize: 18,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget experienciaForm(int index) {
    experienciasControllers.add(TextEditingController());
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        style: TextStyle(
          color: Colors.green,
          fontSize: 20,
        ),
        controller: experienciasControllers[index],
        cursorColor: Colors.green,
        maxLines: null,
        autofocus: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget qualificacaoForm(int index) {
    experienciasControllers.add(TextEditingController());
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        style: TextStyle(
          color: Colors.green,
          fontSize: 20,
        ),
        controller: qualificacoesControllers[index],
        cursorColor: Colors.green,
        maxLines: null,
        autofocus: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
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
                                  TextFormFild("Nome", nomeController),
                                  TextFormFild(
                                      "Email", emailContatoCVController),
                                  TextFormFild("Telefone", telefoneController),
                                  TextFormFild("Sobre", sobreController),
                                  TextFormFild("Semestre", semestreController),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12, top: 24),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20.0)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Experiências",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Spacer(),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      experienciasAdd++;
                                                    });

                                                    print(
                                                        "Total Controllers: ${experienciasControllers.length}");
                                                    print(
                                                        "xp number: ${experienciasAdd}");
                                                  },
                                                  icon: Icon(
                                                    Icons.add_circle,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      findDuplicate(
                                                          experienciasControllers[
                                                                  experienciasAdd]
                                                              .text);

                                                      experienciasControllers[
                                                              experienciasAdd]
                                                          .clear();

                                                      experienciasAdd--;
                                                      experienciasControllers
                                                          .removeLast();
                                                    });

                                                    print(experiencias);
                                                    print(
                                                        "xp number: ${experienciasAdd}");
                                                  },
                                                  icon: Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    for (TextEditingController controller
                                                        in experienciasControllers) {
                                                      experiencias
                                                          .add(controller.text);
                                                    }

                                                    experiencias = experiencias
                                                        .toSet()
                                                        .toList();
                                                    removeVoid();
                                                    print(
                                                        "Total Controllers: ${experienciasControllers.length}");
                                                    print(experiencias);
                                                    print(
                                                        "xp number: ${experienciasAdd}");
                                                  },
                                                  icon: Icon(
                                                    Icons.donut_large,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            for (int i = 0;
                                                i < experienciasAdd;
                                                i++)
                                              experienciaForm(i)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 12.0,
                                      right: 12,
                                      bottom: 12,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(30.0)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Experiências",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Spacer(),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      qualificacoesAdd++;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.add_circle,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      findDuplicate(
                                                          qualificacoesControllers[
                                                                  qualificacoesAdd]
                                                              .text);

                                                      qualificacoesControllers[
                                                              qualificacoesAdd]
                                                          .clear();

                                                      qualificacoesAdd--;
                                                      qualificacoesControllers
                                                          .removeLast();
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    for (TextEditingController controller
                                                        in qualificacoesControllers) {
                                                      qualificacoes
                                                          .add(controller.text);
                                                    }

                                                    qualificacoes =
                                                        qualificacoes
                                                            .toSet()
                                                            .toList();
                                                    removeVoid();
                                                  },
                                                  icon: Icon(
                                                    Icons.donut_large,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            for (int i = 0;
                                                i < qualificacoesAdd;
                                                i++)
                                              qualificacaoForm(i)
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
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

  void findDuplicate(String duplicado) {
    for (String text in experiencias) {
      if (duplicado == text) {
        print("Achou");
        setState(() {
          experiencias.remove(duplicado);
        });
      }
    }
  }

  void removeVoid() {
    print("xpAdd: ${experienciasAdd}\nxpSize: ${experiencias.length}");
    while (experienciasAdd != experiencias.length) {
      print("Removendo Ultimo");
      setState(() {
        experiencias.removeLast();
      });
    }

    for (String text in experiencias) {
      if (text == null) {
        print("Removendo Vazio");
        setState(() {
          experiencias.remove(null);
        });
      }
      if (text == "") {
        print("Removendo Vazio");
        setState(() {
          experiencias.remove("");
        });
      }
      if (text == " ") {
        print("Removendo Vazio");
        setState(() {
          experiencias.remove(" ");
        });
      }
    }
  }
}
