import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:vagas/home/widget/vagaList.dart';
import 'package:vagas/model/MinhaVagaModel.dart';
import 'package:vagas/model/userModel.dart';
import 'package:vagas/model/vagaModel.dart';

class CardDadosWidget extends StatefulWidget {
  CardDadosWidget({
    Key? key,
    required this.usuario,
  }) : super(key: key);
  final User usuario;

  @override
  State<CardDadosWidget> createState() => _CardDadosWidgetState(usuario);
}

class _CardDadosWidgetState extends State<CardDadosWidget> {
  final User usuario;

  _CardDadosWidgetState(
    this.usuario,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
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
