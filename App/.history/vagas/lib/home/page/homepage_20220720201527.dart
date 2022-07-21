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
    return Container();
  }
}
