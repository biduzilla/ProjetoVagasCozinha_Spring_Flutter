import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vagas/model/userAuthModel.dart';
import 'dart:convert';

import '../../model/userModel.dart';

class homePageScreen extends StatefulWidget {
  final UserAuth usuario;
  const homePageScreen({Key? key, required this.usuario}) : super(key: key);

  @override
  State<homePageScreen> createState() => _homePageScreenState(usuario);
}

class _homePageScreenState extends State<homePageScreen> {
  final UserAuth? usuario;

  _homePageScreenState(this.usuario);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Row(children: [
              Text(usuario!.email),
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
