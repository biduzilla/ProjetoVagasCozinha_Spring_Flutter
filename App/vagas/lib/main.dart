import 'package:flutter/material.dart';
import 'package:vagas/auth/page/signUp.dart';
import 'package:vagas/model/userAuthModel.dart';

import 'auth/page/login.dart';
import 'home/page/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UserAuth userAuth = UserAuth(
        email: "toddy@toddy",
        token:
            "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2RkeUB0b2RkeSIsImV4cCI6MTY2MjczODUyMX0.RkH17TI7-p44qigMMtPvZJB5iCQc9mCw2K_XFycjnONhh3R18rVxxZ2x-DcEYpq6CQTwIuIhHr0kSmu4oVLGIQ");
    return MaterialApp(
      home: homePageScreen(usuario: userAuth),
    );
  }
}
