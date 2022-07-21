import 'package:flutter/material.dart';

class homePageScreen extends StatefulWidget {
  final String? token;
  const homePageScreen({Key? key, this.token}) : super(key: key);

  @override
  State<homePageScreen> createState() => _homePageScreenState(token);
}

class _homePageScreenState extends State<homePageScreen> {
  final String? token;

  _homePageScreenState(this.token);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Row(children: [
              Text(context),
            ]),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 1,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
          ),
        ],
      ),
    );
  }
}
