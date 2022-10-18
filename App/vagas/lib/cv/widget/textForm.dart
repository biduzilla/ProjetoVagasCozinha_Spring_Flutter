import 'package:flutter/material.dart';
import 'package:vagas/cv/page/cv.dart';

class TextFormWidget extends StatelessWidget {
  TextFormWidget({
    Key? key,
    required this.text,
    required this.index,
    required this.returnController,
  }) : super(key: key);

  TextEditingController controller = TextEditingController();
  final String text;
  final int index;
  final Function(String, int) returnController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
      child: TextFormField(
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
