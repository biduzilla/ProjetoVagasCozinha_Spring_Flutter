import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:vagas/model/CvModel.dart';
import 'package:vagas/vaga/widget/ContainerText.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class CvDetailsScreen extends StatelessWidget {
  const CvDetailsScreen({Key? key, required this.cv}) : super(key: key);
  final CvModel cv;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0.0,
          titleSpacing: 10.0,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  child: ListView(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              cv.nome.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                        ContainerTextWidget(
                          text: cv.emailContatoCV,
                          type: 'Email',
                          isList: false,
                        ),
                        ContainerTextWidget(
                          text: cv.telefone,
                          type: 'Telefone',
                          isList: false,
                        ),
                        ContainerTextWidget(
                          text: cv.sobre,
                          type: 'Sobre',
                          isList: false,
                        ),
                        ContainerTextWidget(
                          text: cv.semestre,
                          type: 'Semestre',
                          isList: false,
                        ),
                        ContainerTextWidget(
                          cv: cv,
                          type: 'Experiências',
                          isList: true,
                        ),
                        ContainerTextWidget(
                          cv: cv,
                          type: 'Qualificações',
                          isList: true,
                        ),
                      ],
                    ),
                  ])))
        ]));
  }
}
