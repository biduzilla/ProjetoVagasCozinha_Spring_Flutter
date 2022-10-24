import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:vagas/auth/page/login.dart';
import 'package:vagas/cv/widget/ButtonWidget.dart';
import 'package:vagas/cv/widget/footer.dart';
import 'package:vagas/model/userModel.dart';
import 'package:vagas/model/vagaModel.dart';
import 'package:vagas/vaga/widget/expandedContainer.dart';
import 'package:http/http.dart' as http;

class VagaScreen extends StatefulWidget {
  const VagaScreen({Key? key, required this.usuario}) : super(key: key);
  final User usuario;

  @override
  State<VagaScreen> createState() => _VagaScreenState(usuario);
}

class _VagaScreenState extends State<VagaScreen> {
  final User usuario;
  Vaga? vaga;

  _VagaScreenState(this.usuario);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ExpandandedContainerWidget(
            usuario: usuario,
          ),
          // if (vagas.isEmpty)
          //   ExpandandedContainerWidget(
          //     usuario: usuario,
          //   ),
        ],
      ),
      bottomNavigationBar: FooterWidget(usuario: usuario, page: 2),
    );
  }
}
