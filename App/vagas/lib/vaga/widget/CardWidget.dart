import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:vagas/home/widget/vagaList.dart';
import 'package:vagas/model/userModel.dart';
import 'package:vagas/model/vagaModel.dart';

class CardWidget extends StatefulWidget {
  CardWidget({Key? key, this.vagas, required this.usuario}) : super(key: key);
  final List<Vaga>? vagas;
  final User usuario;

  @override
  State<CardWidget> createState() => _CardWidgetState(vagas, usuario);
}

class _CardWidgetState extends State<CardWidget> {
  final List<Vaga>? vagas;
  final User usuario;

  _CardWidgetState(this.vagas, this.usuario);

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
                                  "Vagas Inscritas",
                                  style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          if (vagas != null)
                            for (Vaga vaga in vagas!)
                              vagaList(
                                vaga: vaga,
                                home: false,
                                usuario: usuario,
                              ),
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
