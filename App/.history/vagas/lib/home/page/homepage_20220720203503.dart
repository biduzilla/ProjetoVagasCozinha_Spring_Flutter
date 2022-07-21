import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class homePageScreen extends StatefulWidget {
  final String token;
  const homePageScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<homePageScreen> createState() => _homePageScreenState(token);
}

class _homePageScreenState extends State<homePageScreen> {
  final String token;

  Future<http.Response> signIn(String email, String password) async {
    String token;
    var url = Uri.parse('http://192.168.0.32:8080/api/users/${token}');

    Map data = {
      "email": email,
      "password": password,
    };

    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 201) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => signupScreen()),
      );
    } else {
      alertDialog("Error ao criar conta!");
      print("error");
    }
    return response;
  }

  _homePageScreenState(this.token);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Row(children: [
              Text(context),
            ]),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 1,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
          ),
        ],
      ),
    );
  }
}
