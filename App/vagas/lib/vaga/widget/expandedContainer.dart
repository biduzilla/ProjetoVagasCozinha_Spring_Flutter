import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:vagas/cv/widget/ButtonWidget.dart';
import 'package:vagas/model/userModel.dart';
import 'package:vagas/model/vagaModel.dart';
import 'package:vagas/vaga/widget/CardWidget.dart';

class ExpandandedContainerWidget extends StatefulWidget {
  ExpandandedContainerWidget({Key? key, this.vagas, required this.usuario})
      : super(key: key);
  final List<Vaga>? vagas;
  final User usuario;

  @override
  State<ExpandandedContainerWidget> createState() =>
      _ExpandandedContainerWidgetState(vagas, usuario);
}

class _ExpandandedContainerWidgetState
    extends State<ExpandandedContainerWidget> {
  final List<Vaga>? vagas;
  final User usuario;

  _ExpandandedContainerWidgetState(this.vagas, this.usuario);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (vagas != null)
              CardWidget(
                vagas: vagas,
                usuario: usuario,
              ),
            // if (vagas == null)
            //   CardWidget(
            //     usuario: usuario,
            //   ),

            if (vagas == null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sentiment_neutral_rounded,
                          color: Colors.green,
                          size: 80,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Você ainda não se cadastrou em nenhuma vaga",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 26,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ButtonWidget(
              press: (() {
                print("Acesso: " + usuario.admin.toString());
              }),
              text: "Área da Empresa",
            )
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
