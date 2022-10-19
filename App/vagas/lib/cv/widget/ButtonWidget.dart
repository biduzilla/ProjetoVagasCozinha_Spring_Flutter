import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vagas/model/CvModel.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    Key? key,
    required this.press,
    required this.text,
  }) : super(key: key);

  final Function() press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.green,
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  // Change your radius here
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            onPressed: () {
              press();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
