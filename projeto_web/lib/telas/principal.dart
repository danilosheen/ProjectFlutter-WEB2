// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'Home.dart';
import 'assuntos.dart';
import 'encontros.dart';


class Token{
  String token;
  
  Token(this.token);
  String get getToken => this.token;
}

class PainelPrincipal extends StatefulWidget {

  @override
  _PainelPrincipalState createState() => _PainelPrincipalState();
}

class _PainelPrincipalState extends State<PainelPrincipal> {
  List<String> itensMenu = ["Deslogar"];

  _deslogarUsuario(String item) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel principal"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _deslogarUsuario,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 40, bottom: 20, right: 40),
                child: ElevatedButton(

                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Encontros()));
                  },
                  child: const Text(
                    "Encontros",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 40, bottom: 20, right: 40),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Assuntos()));
                  },
                  child: const Text(
                    "Assuntos",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
