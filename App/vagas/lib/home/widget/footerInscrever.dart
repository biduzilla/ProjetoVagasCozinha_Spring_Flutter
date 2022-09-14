import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FooterInscrever extends StatefulWidget {
  const FooterInscrever({Key? key}) : super(key: key);

  @override
  State<FooterInscrever> createState() => _FooterInscrever();
}

class _FooterInscrever extends State<FooterInscrever> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: Padding(
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.height / 50,
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 100),
              child: Text(
                "Inscrever",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
