// ignore_for_file: use_key_in_widget_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/autenticator.dart';
import '../model/encontro.dart';
import 'package:http/http.dart' as http;

class Encontros extends StatefulWidget {
  @override
  _EncontrosState createState() => _EncontrosState();
}

class _EncontrosState extends State<Encontros> {
  TextEditingController qtdAlunosController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController assuntoController = TextEditingController();

  Future<List<Encontro>> listarEncontros() async {
    var res = await http.get(
      Uri.parse("https://web2-atividade03.vercel.app/encontros"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    List<dynamic> mapJsonEncontro = jsonDecode(res.body);

    return mapJsonEncontro.map((e) => Encontro.fromJson(e)).toList();
  }

  Future<void> remover(int idEncontro) async {
    await http.delete(
      Uri.parse("https://web2-atividade03.vercel.app/encontros/$idEncontro"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-access-token': Autenticator().token!
      },
    );
  }

  Future<void> cadastrar() async {
    await http.post(Uri.parse("https://web2-atividade03.vercel.app/encontros"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': Autenticator().token!
        },
        body: jsonEncode({
          "qtdAlunos": qtdAlunosController.text,
          "data": dataController.text,
          "assunto": assuntoController.text
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
          qtdAlunosController.text = "";
          dataController.text = "";
          assuntoController.text = "";
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Center(child: Text("Cadastrar Encontro")),
                  content: Container(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(
                        children: [
                          const Text("Qtd. Alunos: "),
                          SizedBox(
                            width: 120,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: qtdAlunosController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Data: "),
                          SizedBox(
                            width: 170,
                            child: TextField(
                              controller: dataController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Assunto: "),
                          SizedBox(
                            width: 150,
                            child: TextField(controller: assuntoController),
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
                        child: const Text("Confirmar")),
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
            var encontros = (snapshot.data as List)[0] as List<Encontro>;
            return ListView.builder(
                itemCount: encontros.length,
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
                                      "Código: ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      encontros[index].id.toString(),
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
                                      "Alunos: ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      encontros[index].qtdalunos!,
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
                                      "Data: ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      encontros[index].data!,
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
                                      "Assunto: ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      encontros[index].assunto!,
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
                                                      Text("Excluir encontro")),
                                              content: Text(
                                                  "Você tem certeza que deseja excluir o encontro ${encontros[index].assunto} ?"),
                                              actionsAlignment:
                                                  MainAxisAlignment.center,
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      remover(
                                                          encontros[index].id!);
                                                      setState(() {
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: const Text("Confirmar")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .red)),
                                                    child: const Text("Cancelar"))
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
