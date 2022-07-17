import 'package:flutter/material.dart';

class alertDialag extends StatefulWidget {
  const alertDialag({Key? key}) : super(key: key);

  @override
  State<alertDialag> createState() => _alertDialagState();
}

class _alertDialagState extends State<alertDialag> {
  @override
  Widget build(BuildContext context) {
    Future alertDialog(String text) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                child: Text("OK",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.green)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            title: Text("Alerta!",
                style: TextStyle(fontSize: 28, color: Colors.green)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 30),
                Container(
                  height: MediaQuery.of(context).size.height / 15,
                  child: Text(
                    //'Please rate with star',
                    text,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
