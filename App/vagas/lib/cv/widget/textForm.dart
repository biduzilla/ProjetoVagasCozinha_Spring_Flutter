import 'dart:html';

import 'package:flutter/material.dart';
import 'package:vagas/cv/page/CvSalvar.dart';

class TextFormWidget extends StatefulWidget {
  const TextFormWidget({
    Key? key,
    this.initialValue,
    required this.text,
    required this.index,
    required this.returnController,
    required this.isNumber,
  }) : super(key: key);

  final String? initialValue;
  final String text;
  final int index;

  final Function(String, int) returnController;
  final bool isNumber;
  @override
  State<TextFormWidget> createState() => _TextFormWidgetState(
        initialValue,
        text,
        index,
        isNumber,
        returnController,
      );
}

class _TextFormWidgetState extends State<TextFormWidget> {
  final String? initialValue;
  final String text;
  final int index;
  final Function(String, int) returnController;
  final bool isNumber;
  TextEditingController controller = TextEditingController();

  _TextFormWidgetState(
    this.initialValue,
    this.text,
    this.index,
    this.isNumber,
    this.returnController,
  );

  @override
  void initState() {
    setState(() {
      if (initialValue != null) {
        controller.text = initialValue!;
        returnController(controller.text, index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
      child: TextFormField(
        keyboardType: !isNumber ? TextInputType.number : TextInputType.none,
        style: TextStyle(
          color: Colors.green,
          fontSize: 20,
        ),
        cursorColor: Colors.green,
        controller: controller,
        maxLines: null,
        autofocus: false,
        decoration: InputDecoration(
          filled: true,
          // fillColor: Colors.white,
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
          labelText: text,
          labelStyle: TextStyle(
            fontSize: 18,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        onChanged: (value) {
          returnController(controller.text, index);
        },
      ),
    );
  }
}
