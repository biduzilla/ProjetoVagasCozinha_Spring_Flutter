import 'package:flutter/material.dart';

class loginScreen extends StatelessWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'a ',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  TextSpan(
                      text: 'delivery app ',
                      style: TextStyle(color: Colors.orange, fontSize: 16)),
                  TextSpan(
                    text: 'made for ',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  TextSpan(
                    text: 'you ',
                    style: TextStyle(color: Colors.orange, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
