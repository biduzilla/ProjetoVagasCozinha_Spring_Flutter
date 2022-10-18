import 'package:flutter/material.dart';
import 'package:vagas/cv/widget/ShowText.dart';
import 'package:vagas/cv/widget/inputForm.dart';

class MultipleTextForm extends StatefulWidget {
  MultipleTextForm({
    Key? key,
    required this.title,
    required this.hint,
    required this.getTextList,
    required this.code,
    required this.removeTextList,
  }) : super(key: key);

  final String title;
  final String hint;
  final int code;
  final Function(List<String>, int) getTextList;
  final Function(String, int) removeTextList;

  @override
  State<MultipleTextForm> createState() => _MultipleTextFormState(
        title,
        hint,
        getTextList,
        code,
        removeTextList,
      );
}

class _MultipleTextFormState extends State<MultipleTextForm> {
  _MultipleTextFormState(
      this.title, this.hint, this.getTextList, this.code, this.removeTextList);

  List<String> textList = [];
  final String title;
  final String hint;
  final int code;
  final Function(List<String>, int) getTextList;
  final Function(String, int) removeTextList;

  void addListText(String text) {
    setState(() {
      textList.add(text);
    });
    getTextList(textList, code);
  }

  void removeListText(String text) {
    setState(() {
      textList.remove(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InputFormWidget(
                  hint: hint,
                  addListText: addListText,
                ),
              ],
            ),
          ),
          if (textList.isNotEmpty)
            for (String value in textList)
              ShowTextWidget(
                text: value,
                removeListText: removeListText,
              ),
        ],
      ),
    );
  }
}
