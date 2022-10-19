import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vagas/cv/page/CvSalvar.dart';
import 'package:vagas/home/page/homepage.dart';
import 'package:vagas/model/userAuthModel.dart';
import 'package:vagas/model/userModel.dart';

class FooterWidget extends StatefulWidget {
  FooterWidget({
    Key? key,
    required this.usuario,
    required this.page,
  }) : super(key: key);

  final User usuario;
  final int page;

  @override
  State<FooterWidget> createState() => _FooterWidgetState(usuario, page);
}

class _FooterWidgetState extends State<FooterWidget> {
  final User usuario;
  final int page;

  _FooterWidgetState(this.usuario, this.page);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.green,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: page == 0 ? Colors.amber[800] : Colors.white,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.assignment,
            color: page == 1 ? Colors.amber[800] : Colors.white,
          ),
          label: 'Currículo',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.store,
            color: page == 2 ? Colors.amber[800] : Colors.white,
          ),
          label: 'Vagas',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: page == 3 ? Colors.amber[800] : Colors.white,
          ),
          label: 'Meus Dados',
        ),
      ],
      currentIndex: 1,
      unselectedItemColor: Colors.white,
      unselectedLabelStyle: TextStyle(color: Colors.white, fontSize: 14),
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => homePageScreen(
            usuario: UserAuth(
              email: usuario.email,
              token: usuario.token,
            ),
          ),
        ),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CvPageScreen(usuario: usuario),
        ),
      );
    }
  }
}
