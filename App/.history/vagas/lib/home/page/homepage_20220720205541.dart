import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../model/userModel.dart';

class homePageScreen extends StatefulWidget {
  final String? token;
  const homePageScreen({Key? key, this.token}) : super(key: key);

  @override
  State<homePageScreen> createState() => _homePageScreenState(token);
}

class _homePageScreenState extends State<homePageScreen> {
  final String? token;
  User? usuario;
  String? email;

  void initState() {
    super.initState();

    setState(() {
      if (email == null) {
        email = "carregando";
      } else {
        signIn();
        email = usuario!.email;
      }
    });
  }

  Future<User?> getUser() async {
    var url = Uri.parse('http://192.168.0.32:8080/api/users/${token}');

    // Map data = {
    //   "P_id": product,
    // };
    //encode Map to JSON
    // var body = json.encode(data);

    // var response = await http.post(url,
    //     headers: {"Content-Type": "application/json"}, body: body);

    var response =
        await http.post(url, headers: {"Content-Type": "application/json"});

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      print("Mostrar Produto sucesso!");

      setState(() {
        usuario = User.fromJson(jsonDecode(response.body));
      });
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Mostrar Produto Error');
    }
  }

  Future<http.Response> signIn() async {
    var url = Uri.parse('http://192.168.0.32:8080/api/users/${token}');

    var response =
        await http.post(url, headers: {"Content-Type": "application/json"});

    setState(() {
      usuario = User.fromJson(jsonDecode(response.body));
    });

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 201) {
      print("Get User OK");
    } else {
      print("Error Get User");
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
              Text(email!),
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
