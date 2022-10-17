import 'package:flutter/material.dart';
import 'package:vagas/cv/widget/ShowText.dart';
import 'package:vagas/cv/widget/inputForm.dart';

class MultipleTextForm extends StatefulWidget {
  MultipleTextForm({
    Key? key,
    required this.title1,
    required this.title2,
  }) : super(key: key);

  final String title1;
  final String title2;

  @override
  State<MultipleTextForm> createState() =>
      _MultipleTextFormState(title1, title2);
}

class _MultipleTextFormState extends State<MultipleTextForm> {
  _MultipleTextFormState(this.title1, this.title2);

  List<String> textList = [];
  final String title1;
  final String title2;

  int index = 0;

  void addListText(String text) {
    setState(() {
      textList.add(text);
      print("${index}");
      index++;
    });
  }

  void removeListText(String text) {
    print(text);
    setState(() {
      textList.remove(text);
    });

    // setState(() {
    //   print("Removendo texto ${textList[index]} no indext ${index}");
    //   textList.remove(text);
    // });
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
                    title1,
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
            for (String value in textList)
              ShowTextWidget(
                text: value,
                index: index,
                removeListText: removeListText,
              ),
        ],
      ),
    );
  }
}
