// ignore_for_file: prefer_final_fields, prefer_const_constructors
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:primeiro_projeto/telas/principal.dart';
import 'dart:convert';

import '../model/autenticator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  Future<http.Response?> login() async {
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    var res = await http.post(
      Uri.parse("http://127.0.0.1/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"user": email, "pass": senha}),
    );
    Map<String, dynamic> variavel = jsonDecode(res.body);
    var token = (variavel['token']);
    if (token != null) {
      Autenticator aut = Autenticator();
      aut.token = token;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => PainelPrincipal()),
        (Route<dynamic> route) => false,
      );
    } else {
      setState(() {
        _mensagemErro =
            "Erro ao autenticar usuário, verifique e-mail e senha e tente novamente!";
      });
    }
    return null;
    //return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 32),
                child: Image.asset(
                  "images/logo.png",
                  width: 200,
                  height: 250,
                ),
              ),
              TextField(
                controller: _controllerEmail,
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Usuario",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _controllerSenha,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Senha",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 40, bottom: 20, right: 40),
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await Future.delayed(Duration(seconds: 1));
                    login().then((value) {
                      isLoading = false;
                    });
                  },
                  child: isLoading
                      ? Container(
                          height: 35,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          height: 35,
                          child: Center(
                            child: Text(
                              "Entrar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Center(
                  child: Text(
                    _mensagemErro,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
