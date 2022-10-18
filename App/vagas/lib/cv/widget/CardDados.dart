import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vagas/model/CvModel.dart';
import 'package:flutter/material.dart';

class CardDadosWidget extends StatefulWidget {
  CardDadosWidget({
    Key? key,
    required this.cv,
  }) : super(key: key);
  final CvModel cv;
  @override
  State<CardDadosWidget> createState() => _CardDadosWidgetState(cv);
}

class _CardDadosWidgetState extends State<CardDadosWidget> {
  final CvModel cv;

  _CardDadosWidgetState(this.cv);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                reverse: false,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Meu Currículo"),
                          Text(
                            'Nome: ' + cv.nome,
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          Text("Email: " + cv.emailContatoCV),
                          Text("Telefone: " + cv.telefone),
                          Text("Sobre: " + cv.sobre),
                          Text("Semestre: " + cv.semestre),
                          Text("Experiências: " + cv.experiencias.toString()),
                          Text("Qualificações: " + cv.qualificacoes.toString()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
      ),
    );
  }
}
