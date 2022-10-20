import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vagas/auth/page/login.dart';
import 'package:vagas/auth/widget/alert.dart';
import 'package:vagas/cv/page/CvMostrar.dart';
import 'package:vagas/cv/page/CvSalvar.dart';
import 'package:vagas/cv/widget/footer.dart';
import 'package:vagas/home/widget/noVagas.dart';
import 'package:vagas/home/widget/vagaList.dart';
import 'package:vagas/model/VagaListIdModel.dart';
import 'package:vagas/model/vagaModel.dart';
import 'dart:convert';

import '../../model/userModel.dart';

class homePageScreen extends StatefulWidget {
  final User usuario;

  const homePageScreen({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  @override
  State<homePageScreen> createState() => _homePageScreenState(
        usuario,
      );
}

class _homePageScreenState extends State<homePageScreen> {
  final User usuario;
  Vaga? vaga;
  int _selectedIndex = 0;
  List<Vaga> vagas = [];
  VagaListIdModel? vagaListIdModel;
  TextEditingController cargoController = TextEditingController();
  String? cargo;

  Future alertDialog(String text, int code) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              child: Text(
                "OK",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                if (code == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => loginScreen(),
                    ),
                  );
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ],
          title: Text("Alerta!",
              style: TextStyle(fontSize: 28, color: Colors.black)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                child: Text(
                  //'Please rate with star',
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> getListLastVagas() async {
    var url = Uri.parse('http://10.61.104.110:8081/api/vagas/lastVagas');
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer ' + usuario.token,
    });

    try {
      if (response.statusCode == 403 ||
          response.statusCode == 401 ||
          response.statusCode != 200) {
        alertDialog("Entre novamento na sua conta!", 1);
      } else {
        vagaListIdModel = VagaListIdModel.fromJson(jsonDecode(response.body));
        setState(() {
          for (int idVaga in vagaListIdModel!.vagaId) {
            getVaga(idVaga);
          }
        });
      }
    } on Exception catch (_) {
      print("Error Requisição getListLastVagas");
    }
  }

  Future<void> searchCargo(String cargo) async {
    var url = Uri.parse(
        'http://10.61.104.110:8081/api/vagas/procurar?cargo=${cargo}');
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer ' + usuario.token,
    });

    if (response.statusCode == 404) {
      alertDialog("Vaga não Encontrada!", 0);
    } else if (response.statusCode == 200) {
      vagaListIdModel = VagaListIdModel.fromJson(jsonDecode(response.body));
      setState(
        () {
          for (int idVaga in vagaListIdModel!.vagaId) {
            getVaga(idVaga);
          }
        },
      );
    } else if (response.statusCode == 403 || response.statusCode == 401) {
      alertDialog("Entre novamento na sua conta!", 1);
    }
  }

  Future<void> getVaga(int idVaga) async {
    var url = Uri.parse('http://10.61.104.110:8081/api/vagas/${idVaga}');
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer ' + usuario.token,
    });

    print("getVaga" + response.body);

    if (response.statusCode == 403) {
      alertDialog("Entre novamento na sua conta!", 1);
    } else {
      setState(() {
        vaga = Vaga.fromJson(jsonDecode(response.body));
        vagas.add(vaga!);
      });
    }
  }

  void initState() {
    super.initState();
    setState(() {
      getListLastVagas();
    });
  }

  Widget _buildSearchCargo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
      child: TextFormField(
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
        onChanged: (text) {
          setState(() {
            vagas.clear();
            vagaListIdModel!.vagaId.clear();
          });
        },
        cursorColor: Colors.green,
        controller: cargoController,
        autofocus: false,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                print(vagas.length);
                cargo = cargoController.text;
                searchCargo(cargo!);
                cargoController.clear();
              });
            },
            icon: Icon(
              Icons.search,
              color: Colors.green,
              size: 28,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: "Ex: Cozinheiro...",
          hintStyle: TextStyle(
            fontSize: 18,
            color: Colors.green,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  _homePageScreenState(
    this.usuario,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                "Encontre a Vaga",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                "Certa para Você!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            _buildSearchCargo(),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Vagas Recentes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          // if (vagas.isEmpty) NoVagas(),
                          Column(
                            children: [
                              if (vagas != null)
                                for (Vaga vagaDaLista in vagas)
                                  vagaList(
                                    vaga: vagaDaLista,
                                    usuario: usuario,
                                  )
                            ],
                          ),
                        ],
                      ),
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
            ),
          ],
        ),
        bottomNavigationBar: FooterWidget(usuario: usuario, page: 0),
      ),
    );
  }
}
