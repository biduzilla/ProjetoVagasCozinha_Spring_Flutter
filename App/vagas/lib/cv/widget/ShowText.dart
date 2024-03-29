import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class ShowTextWidget extends StatelessWidget {
  ShowTextWidget({Key? key, required this.text, required this.removeListText})
      : super(key: key);

  final String text;

  final Function(String) removeListText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.45,
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          // Spacer(),
          Container(
            child: IconButton(
              icon: Icon(
                Icons.remove_circle,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                print("Remover");
                removeListText(text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
