import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class loginScreen extends StatelessWidget {
  loginScreen({Key? key}) : super(key: key);

  String? email;
  String? password;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Widget _buildEmailTF() {
    email = emailController.text;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          validator: (value) {
            if (value!.length < 5) {
              return "Email muito curto";
            } else if (!value.contains("@")) {
              return "Email Inválido";
            }
            return null;
          },
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            labelText: "Email",
            labelStyle: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
            filled: true,
            fillColor: Colors.green,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTF() {
    email = emailController.text;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          validator: (value) {
            if (value!.length < 5) {
              return "Senha muito curto";
            }
            return null;
          },
          controller: passwordController,
          obscureText: true,
          autofocus: false,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            labelText: "Password",
            labelStyle: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
            filled: true,
            fillColor: Colors.green,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Cook ',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'Up',
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.restaurant_menu,
                      color: Colors.green,
                      size: 90,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Encontre as oportunidades perfeitas para você",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: SvgPicture.asset(
                    'lib/assets/images/logo.svg',
                  ),
                ),
                _buildEmailTF(),
                _buildPasswordTF(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
