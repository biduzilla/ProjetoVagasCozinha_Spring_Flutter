import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CvBlockWidget extends StatefulWidget {
  const CvBlockWidget({Key? key}) : super(key: key);

  @override
  State<CvBlockWidget> createState() => _CvBlockWidgetState();
}

class _CvBlockWidgetState extends State<CvBlockWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Vagas Recentes",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.green,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  // if (vagas.isEmpty) NoVagas(),
                  Column(
                    children: [],
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
