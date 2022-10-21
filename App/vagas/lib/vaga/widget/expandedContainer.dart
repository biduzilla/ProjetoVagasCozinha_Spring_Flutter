import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:vagas/model/vagaModel.dart';
import 'package:vagas/vaga/widget/CardWidget.dart';

class ExpandandedContainerWidget extends StatefulWidget {
  ExpandandedContainerWidget({Key? key, this.vagas}) : super(key: key);
  final List<Vaga>? vagas;

  @override
  State<ExpandandedContainerWidget> createState() =>
      _ExpandandedContainerWidgetState(vagas);
}

class _ExpandandedContainerWidgetState
    extends State<ExpandandedContainerWidget> {
  final List<Vaga>? vagas;

  _ExpandandedContainerWidgetState(this.vagas);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardWidget(
              vagas: vagas,
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
