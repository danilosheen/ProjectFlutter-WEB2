// ignore_for_file: use_key_in_widget_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:primeiro_projeto/model/assunto.dart';
import '../model/autenticator.dart';
import 'package:http/http.dart' as http;

class Assuntos extends StatefulWidget {
  @override
  _AssuntosState createState() => _AssuntosState();
}

class _AssuntosState extends State<Assuntos> {
  TextEditingController idAssuntosController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController grauDificuldadeController = TextEditingController();
  TextEditingController tempoNecessarioController = TextEditingController();

  Future<List<Assunto>> listarEncontros() async {
    var res = await http.get(
      Uri.parse("https://web2-atividade03.vercel.app/assuntos"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    List<dynamic> mapJsonAssunto = jsonDecode(res.body);

    return mapJsonAssunto.map((e) => Assunto.fromJson(e)).toList();
  }

  Future<void> remover(int idAssunto) async {
    await http.delete(
      Uri.parse("https://web2-atividade03.vercel.app/assuntos/$idAssunto"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-access-token': Autenticator().token!
      },
    );
  }

  Future<void> cadastrar() async {
    await http.post(Uri.parse("https://web2-atividade03.vercel.app/assuntos"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': Autenticator().token!
        },
        body: jsonEncode({
          "id": idAssuntosController.text,
          "nome": nomeController.text,
          "grauDificuldade": grauDificuldadeController.text,
          "tempoNecessario": tempoNecessarioController.text
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 248, 252, 253),
      appBar: AppBar(
        title: const Text("Encontros"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          idAssuntosController.text = "";
          nomeController.text = "";
          grauDificuldadeController.text = "";
          tempoNecessarioController.text = "";
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Center(child: Text("Cadastrar Assunto")),
                  content: Container(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(
                        children: [
                          const Text("Id: "),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: idAssuntosController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Nome: "),
                          SizedBox(
                            width: 170,
                            child: TextField(
                              controller: nomeController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Grau de dificuldade: "),
                          SizedBox(
                            width: 75,
                            child: TextField(
                              controller: grauDificuldadeController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Tempo Necessário: "),
                          SizedBox(
                            width: 80,
                            child: TextField(
                              controller: tempoNecessarioController,
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        cadastrar().then(
                          (value) {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                        );
                      },
                      child: const Text("Confirmar"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        child: const Text("Cancelar"))
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: Future.wait([listarEncontros()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var assuntos = (snapshot.data as List)[0] as List<Assunto>;
            return ListView.builder(
                itemCount: assuntos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Id: ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      assuntos[index].id.toString(),
                                      style: const TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Nome: ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      assuntos[index].nome!,
                                      style: const TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Grau de dificuldade: ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      assuntos[index].graudificuldade!,
                                      style: const TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Tempo Necessário: ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      assuntos[index].temponecessario!,
                                      style: const TextStyle(fontSize: 18),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Center(
                                                  child:
                                                      Text("Excluir asunto")),
                                              content: Text(
                                                  "Você tem certeza que deseja excluir o encontro ${assuntos[index].nome} ?"),
                                              actionsAlignment:
                                                  MainAxisAlignment.center,
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      remover(
                                                          assuntos[index].id!);
                                                      setState(() {
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: const Text(
                                                        "Confirmar")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .red)),
                                                    child:
                                                        const Text("Cancelar"))
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
