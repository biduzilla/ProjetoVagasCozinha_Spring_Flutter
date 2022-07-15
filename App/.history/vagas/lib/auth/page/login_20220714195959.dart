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
          style: TextStyle(color: Colors.green),
          cursorColor: Colors.green,
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
              color: Colors.green,
            ),
            // filled: true,
            // fillColor: Colors.white,
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
          style: TextStyle(color: Colors.green),
          cursorColor: Colors.green,
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
              color: Colors.green,
            ),
            // filled: true,
            // fillColor: Colors.white,
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
                  height: MediaQuery.of(context).size.height / 12,
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
                                color: Color(0xffff6442),
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
                    "Encontre oportunidades perfeitas para você",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3.2,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: SvgPicture.asset(
                      'lib/assets/images/logo.svg',
                    ),
                  ),
                ),
                _buildEmailTF(),
                _buildPasswordTF(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffff6442),
                      fixedSize: Size(220, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                    child: const Text('Log In'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
