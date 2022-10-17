import 'package:flutter/foundation.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InputFormWidget extends StatefulWidget {
  InputFormWidget({Key? key, required this.hint, required this.addListText})
      : super(key: key);
  final String hint;
  final Function(String) addListText;

  @override
  State<InputFormWidget> createState() => _InputFormWidgetState(
        hint,
        addListText,
      );
}

class _InputFormWidgetState extends State<InputFormWidget> {
  final String hint;
  final Function(String) addListText;

  _InputFormWidgetState(this.hint, this.addListText);

  String? errorText;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.green,
        fontSize: 20,
      ),
      cursorColor: Colors.green,
      controller: textController,
      maxLines: null,
      decoration: InputDecoration(
        errorText: errorText,
        errorStyle: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.green,
          fontSize: 20,
        ),
        suffixIcon: IconButton(
          onPressed: (() {
            if (textController.text.isEmpty) {
              setState(() {
                errorText = "Campo não pode ser vazio!";
                return;
              });
            } else {
              setState(() {
                errorText = null;
                addListText(textController.text);
                textController.clear();
              });
            }
          }),
          icon: Icon(
            Icons.add_circle,
            color: Colors.green,
          ),
        ),
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
      ),
    );
  }
}
