import 'package:flutter/material.dart';
import 'package:vagas/cv/widget/ShowText.dart';
import 'package:vagas/cv/widget/inputForm.dart';

class MultipleTextForm extends StatefulWidget {
  MultipleTextForm({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MultipleTextForm> createState() => _MultipleTextFormState(title);
}

class _MultipleTextFormState extends State<MultipleTextForm> {
  _MultipleTextFormState(this.title);

  List<String> textList = [];
  final String title;
  int index = 0;

  void addListText(String text) {
    setState(() {
      textList.add(text);
      print("${index}");
      index++;
    });
  }

  void removeListText(String text) {
    setState(() {
      print("Removendo texto ${textList[index]} no indext ${index}");
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
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                  30,
                ),
              ),
            ),
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
                  hint: "Minhas Experiencias",
                  addListText: addListText,
                ),
              ],
            ),
          ),
          if (textList.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              itemCount: textList.length,
              itemBuilder: (BuildContext context, int index) {
                return ShowTextWidget(
                  text: textList[index],
                  index: index,
                  removeListText: removeListText,
                );
              },
            ),
        ],
      ),
    );
  }
}
