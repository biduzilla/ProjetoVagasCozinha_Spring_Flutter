import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:vagas/auth/page/signUp.dart';
import 'package:vagas/auth/widget/alert.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreen();
}

class _loginScreen extends State<loginScreen> {
  String? email;
  String? password;
  String? errorText;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Widget _buildEmailTF() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: 300,
        child: TextField(
          style: TextStyle(color: Colors.green),
          cursorColor: Colors.green,
          controller: emailController,
          decoration: InputDecoration(
            errorText: errorText,
            errorStyle: TextStyle(color: Colors.red),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            labelText: "Email",
            labelStyle: TextStyle(
              fontSize: 18,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTF() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: 300,
        child: TextField(
          style: TextStyle(color: Colors.green),
          cursorColor: Colors.green,
          controller: passwordController,
          obscureText: true,
          autofocus: false,
          decoration: InputDecoration(
            errorText: errorText,
            errorStyle: TextStyle(color: Colors.red),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            labelText: "Password",
            labelStyle: TextStyle(
              fontSize: 18,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }

  Future<http.Response> login(String email, String password) async {
    String token;
    var url = Uri.parse('http://192.168.0.32:8080/api/users/salvar');

    Map data = {
      "email": email,
      "password": password,
    };

    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      alertSpam(text: response.body);
      print("ok!");
    } else {
      alertSpam(text: response.body);
      print("error");
    }
    return response;
  }

  Future alertDialog(String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              child: Text("OK",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          title: Text("Alerta!",
              style: TextStyle(fontSize: 28, color: Colors.green)),
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
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Cook ',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'Up',
                            style: TextStyle(
                                color: Color(0xffff6442),
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.restaurant_menu,
                      color: Colors.green,
                      size: 90,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Encontre oportunidades perfeitas para você",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3.5,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: SvgPicture.asset(
                      'lib/assets/images/logo.svg',
                    ),
                  ),
                ),
                _buildEmailTF(),
                _buildPasswordTF(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffff6442),
                    fixedSize: Size(220, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    String email = emailController.text;
                    String password = passwordController.text;

                    if (email.length < 5) {
                      setState(() {
                        errorText = "Email Inválido!";
                      });
                      return;
                    } else if (!email.contains("@")) {
                      setState(() {
                        errorText = "Email Inválido!";
                      });
                      return;
                    } else if (password.length < 5) {
                      setState(() {
                        errorText = "Senha muito curta!";
                      });
                      return;
                    }

                    login(email, password);
                  },
                  child: const Text('Log In'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ainda não possui conta?",
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        print("resetar password");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => signupScreen()),
                        );
                      },
                      child: Text(
                        "Registre",
                        style: TextStyle(
                          color: Color(0xffff6442),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
