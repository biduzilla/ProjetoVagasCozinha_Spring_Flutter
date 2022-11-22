import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vagas/cv/widget/footer.dart';
import 'package:vagas/meuDados/widget/ExpandandedDadosWidget.dart';
import 'package:vagas/model/userModel.dart';

class MeusDadosScreen extends StatefulWidget {
  const MeusDadosScreen({Key? key, required this.usuario}) : super(key: key);
  final User usuario;
  @override
  State<MeusDadosScreen> createState() => _MeusDadosScreenState(usuario);
}

class _MeusDadosScreenState extends State<MeusDadosScreen> {
  final User usuario;

  _MeusDadosScreenState(this.usuario);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 28,
                ),
                Text(
                  usuario.email,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          ExpandandedDadosWidget(
            usuario: usuario,
          )
        ],
      ),
      bottomNavigationBar: FooterWidget(usuario: usuario, page: 3),
    );
  }
}
