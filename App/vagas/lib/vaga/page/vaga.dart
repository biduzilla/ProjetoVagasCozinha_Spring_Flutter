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
  const VagaScreen({Key? key, required this.usuario, required this.empresa})
      : super(key: key);
  final User usuario;
  final bool empresa;

  @override
  State<VagaScreen> createState() => _VasaScreenState(usuario, empresa);
}

class _VasaScreenState extends State<VagaScreen> {
  final User usuario;
  final bool empresa;

  _VasaScreenState(this.usuario, this.empresa);
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
            empresa: empresa,
            usuario: usuario,
          ),
        ],
      ),
      bottomNavigationBar: FooterWidget(usuario: usuario, page: 2),
    );
  }
}
