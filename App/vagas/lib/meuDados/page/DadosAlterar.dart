import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vagas/auth/page/login.dart';
import 'package:vagas/cv/widget/ButtonWidget.dart';
import 'package:vagas/cv/widget/footer.dart';
import 'package:vagas/cv/widget/textForm.dart';
import 'package:vagas/home/page/homepage.dart';
import 'package:vagas/model/userUpdateModel.dart';
import 'dart:convert';
import '../../../model/userModel.dart';

class DadosAlterarScreen extends StatefulWidget {
  final User usuario;

  DadosAlterarScreen({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  @override
  State<DadosAlterarScreen> createState() => _DadosAlterarScreenState(
        usuario,
      );
}

class _DadosAlterarScreenState extends State<DadosAlterarScreen> {
  final User usuario;
  String? email;
  String? senha;

  void montarDados() {
    if (email == null || senha == null) {
      alertDialog("Preencha os dados!", 3);
    } else {
      if (email!.length < 5) {
        alertDialog("Email Invalido", 3);
      } else if (!email!.contains("@")) {
        alertDialog("Email Invalido", 3);
      } else if (senha!.length < 5) {
        alertDialog("Senha muito curta!", 3);
      } else {
        updateUser();
      }
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

  Future<void> updateUser() async {
    var url = Uri.parse('http://10.61.104.110:8081/api/users/atualizar');
    Map data = {
      'email': email,
      'password': senha,
      'token': usuario.token,
    };
    var body = json.encode(data);
    var response = await http.put(url,
        headers: {
          'Authorization': 'Bearer ' + usuario.token,
          'Content-Type': 'application/json',
        },
        body: body);

    if (response.statusCode.toString().contains('20')) {
      UserUpdate update = UserUpdate.fromJson(jsonDecode(response.body));
      print("token: " + update.token + " -- email: " + update.email);
      usuario.token = update.token;
      usuario.email = update.email;
      alertDialog('Atualizado com Sucesso', 0);
    } else if (response.statusCode == 400) {
      print(response.body);
      alertDialog("Usuario já cadastrado", 3);
    } else {
      print(response.body);
      alertDialog("Codigo Error:" + response.statusCode.toString(), 0);
    }
  }

  _DadosAlterarScreenState(this.usuario);
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
                              text: "Email",
                              index: 1,
                              returnController: returnController,
                              isNumber: false,
                            ),
                            TextFormWidget(
                              text: "Senha",
                              index: 2,
                              returnController: returnController,
                              isNumber: false,
                            ),
                            ButtonWidget(
                              press: montarDados,
                              text: 'Alterar Dados',
                            ),
                          ],
                        ),
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
        bottomNavigationBar: FooterWidget(usuario: usuario, page: 1),
      ),
    );
  }

  void returnController(String text, int index) {
    switch (index) {
      case 1:
        email = text;
        break;
      case 2:
        senha = text;
        break;
    }
  }
}
