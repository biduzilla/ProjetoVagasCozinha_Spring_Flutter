import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:vagas/home/widget/vagaList.dart';
import 'package:vagas/model/CvModel.dart';
import 'package:vagas/model/vagaModel.dart';
import 'package:vagas/vaga/widget/CvList.dart';

class CvBlockWidget extends StatelessWidget {
  CvBlockWidget({Key? key, required this.vaga}) : super(key: key);
  final Vaga vaga;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Currículos Recebidos",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20))),
              child: Column(children: [
                for (CvModel cv in vaga.curriculumDtos)
                  CvListWidget(
                    cv: cv,
                  )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
