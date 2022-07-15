import 'package:flutter/material.dart';

class loginScreen extends StatelessWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Cock ',
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                  TextSpan(
                      text: 'Up',
                      style: TextStyle(color: Colors.orange, fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
