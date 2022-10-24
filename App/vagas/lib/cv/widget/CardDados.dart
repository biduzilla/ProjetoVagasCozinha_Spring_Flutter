import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vagas/cv/page/CvSalvar.dart';
import 'package:vagas/cv/widget/ButtonWidget.dart';
import 'package:vagas/cv/widget/InfoCardDados.dart';
import 'package:vagas/model/CvModel.dart';
import 'package:flutter/material.dart';
import 'package:vagas/model/userAuthModel.dart';
import 'package:vagas/model/userModel.dart';

class CardDadosWidget extends StatefulWidget {
  CardDadosWidget({
    Key? key,
    required this.cv,
    required this.usuario,
  }) : super(key: key);

  final CvModel cv;
  final User usuario;
  @override
  State<CardDadosWidget> createState() => _CardDadosWidgetState(
        cv,
        usuario,
      );
}

class _CardDadosWidgetState extends State<CardDadosWidget> {
  final CvModel cv;
  final User usuario;

  _CardDadosWidgetState(
    this.cv,
    this.usuario,
  );

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
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(
                                  30,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Meu Currículo",
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InfoCardDadosWidget(
                            info: "Nome",
                            dados: cv.nome,
                            usuario: usuario,
                          ),
                          InfoCardDadosWidget(
                            info: "Email",
                            dados: cv.emailContatoCV,
                            usuario: usuario,
                          ),
                          InfoCardDadosWidget(
                            info: "Telefone",
                            dados: cv.telefone,
                            usuario: usuario,
                          ),
                          InfoCardDadosWidget(
                            info: "Semestre",
                            dados: cv.semestre,
                            usuario: usuario,
                          ),
                          InfoCardDadosWidget(
                            info: "Sobre",
                            dados: cv.sobre,
                            usuario: usuario,
                          ),
                          InfoCardDadosWidget(
                            info: "Experiências",
                            lstDados: cv.experiencias,
                            usuario: usuario,
                          ),
                          InfoCardDadosWidget(
                            info: "Qualificações",
                            lstDados: cv.qualificacoes,
                            usuario: usuario,
                          ),
                          ButtonWidget(
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CvPageScreen(
                                      usuario: usuario,
                                    ),
                                  ),
                                );
                              },
                              text: "Editar Currículo")
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
