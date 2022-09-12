import 'package:flutter/material.dart';

class NoVagas extends StatelessWidget {
  const NoVagas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Icon(
            Icons.sentiment_dissatisfied,
            color: Colors.green,
            size: 70,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Sem Vagas para Ver",
            style: TextStyle(
              fontSize: 28,
              color: Colors.green,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
