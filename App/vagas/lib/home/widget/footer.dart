import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vagas/home/page/homepage.dart';
import 'package:vagas/model/userAuthModel.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({Key? key, this.usuario}) : super(key: key);
  final UserAuth? usuario;

  @override
  State<FooterWidget> createState() => _FooterWidgetState(usuario);
}

class _FooterWidgetState extends State<FooterWidget> {
  final UserAuth? usuario;
  int _selectedIndex = 0;

  _FooterWidgetState(this.usuario);

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => homePageScreen(usuario: usuario!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.amber[800],
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.business,
              color: Colors.white,
            ),
            label: 'Currículo',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.school,
              color: Colors.white,
            ),
            label: 'Vagas',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            label: 'Meus Dados',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
        unselectedLabelStyle: TextStyle(color: Colors.white, fontSize: 14),
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
