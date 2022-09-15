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

class testeScreen extends StatefulWidget {
  const testeScreen({Key? key}) : super(key: key);

  @override
  State<testeScreen> createState() => _testeScreenState();
}

class _testeScreenState extends State<testeScreen> {
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> textFieldControllers = [];
  int numberOfTextFields = 0;

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
                return TextFormField(
                  validator: (String? value) {
                    double? sal = double.tryParse(value!);
                    if (sal == null) {
                      return 'enter or delete row';
                    }
                    return null;
                  },
                  controller: textFieldControllers[index],
                );
              },
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: TextButton(
          //     onPressed: () {
          //       if (_formKey.currentState!.validate()) {
          //         showDialog(
          //             context: context,
          //             builder: (BuildContext context) {
          //               return Center();
          //             });
          //       }
          //     },
          //     child: Container(
          //       padding: EdgeInsets.all(10.0),
          //       color: Colors.redAccent,
          //       child: Text('Tap to sum'),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void addNewTextField() {
    textFieldControllers.add(TextEditingController());
    numberOfTextFields++;
    setState(() {});
  }

  @override
  void dispose() {
    textFieldControllers
        .forEach((textFieldController) => textFieldController.dispose());
    super.dispose();
  }
}
