import 'package:flutter/material.dart';
//import 'Rotas.dart';
import 'telas/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
    title: "PSW2",
    home: Home(),
    initialRoute: "/",
    //onGenerateRoute: Rotas.gerarRotas,
    debugShowCheckedModeBanner: false,
  ));
}
