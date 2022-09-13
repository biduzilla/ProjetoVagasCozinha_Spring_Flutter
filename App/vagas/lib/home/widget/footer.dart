import 'package:flutter/material.dart';
import 'package:vagas/home/page/homepage.dart';
import 'package:vagas/model/userAuthModel.dart';

class footerWidget extends StatelessWidget {
  const footerWidget({Key? key, this.usuario}) : super(key: key);
  final UserAuth? usuario;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 28.0, bottom: 28),
      child: Container(
        color: Colors.green,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.07,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => homePageScreen(usuario: usuario!),
                    ),
                  )),
              icon: Icon(
                Icons.home_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.15),
            IconButton(
              onPressed: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => homePageScreen(usuario: usuario!),
                    ),
                  )),
              icon: Icon(
                Icons.assignment_ind_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.15),
            IconButton(
              onPressed: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => homePageScreen(usuario: usuario!),
                    ),
                  )),
              icon: Icon(
                Icons.store_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.15),
            IconButton(
              onPressed: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => homePageScreen(usuario: usuario!),
                    ),
                  )),
              icon: Icon(
                Icons.settings_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
