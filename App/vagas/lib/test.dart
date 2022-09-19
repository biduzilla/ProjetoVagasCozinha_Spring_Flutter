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

class teste2Screen extends StatefulWidget {
  const teste2Screen({Key? key}) : super(key: key);

  @override
  State<teste2Screen> createState() => _teste2ScreenState();
}

class _teste2ScreenState extends State<teste2Screen> {
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> textFieldControllers = [];
  int numberOfTextFields = 0;
  List<String> textos = [];

  Widget _experienciaForm(int index) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        style: TextStyle(
          color: Colors.green,
          fontSize: 20,
        ),
        controller: textFieldControllers[index],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewTextField();
        },
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView.builder(
              itemCount: numberOfTextFields,
              itemBuilder: (BuildContext context, int index) {
                return _experienciaForm(index);
              },
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                for (TextEditingController controller in textFieldControllers) {
                  textos.add(controller.text);
                }
              });
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.redAccent,
              child: Text('Show'),
            ),
          ),
        ],
      ),
    );
  }

  void addNewTextField() {
    textFieldControllers.add(TextEditingController());
    numberOfTextFields++;
    setState(() {
      print(textos);
    });
  }
}
