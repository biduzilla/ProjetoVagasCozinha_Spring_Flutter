import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vagas/home/widget/footer.dart';
import 'package:vagas/home/widget/noVagas.dart';
import 'package:vagas/home/widget/vagaList.dart';
import 'package:vagas/model/userAuthModel.dart';
import 'package:vagas/model/vaga.dart';
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
  Vaga? vaga;
  List<Vaga> vagas = [];
  TextEditingController cargoController = TextEditingController();
  String? cargo;

  Vaga vagaTeste = Vaga(
    cargo: "cachorro de oficina",
    descricao: "cuidar da oficina",
    local: "bandera",
    horario: "tarde",
    requisitos: ["correr", "pular"],
    remuneracao: 123.12,
    dataPostada: "01/01/2022",
  );

  void initState() {
    super.initState();
    setState(() {
      vagas.add(vagaTeste);
    });
  }

  Widget _buildSearchCargo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
      child: TextFormField(
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
        cursorColor: Colors.green,
        controller: cargoController,
        autofocus: false,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              cargo = cargoController.text;
              cargoController.clear();
              print(cargo);
            },
            icon: Icon(
              Icons.search,
              color: Colors.green,
              size: 28,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: "Ex: Cozinheiro...",
          hintStyle: TextStyle(
            fontSize: 18,
            color: Colors.green,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  _homePageScreenState(this.usuario);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        print(vagas.length);
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                "Encontre a Vaga",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                "Certa para Você!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            _buildSearchCargo(),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Vagas Recentes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          if (vagas.isEmpty) NoVagas(),
                          Column(
                            children: [
                              for (Vaga vagaDaLista in vagas)
                                vagaList(
                                  vaga: vagaDaLista,
                                  usuario: usuario!,
                                )
                            ],
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
            footerWidget(usuario: usuario)
          ],
        ),
      ),
    );
  }
}
