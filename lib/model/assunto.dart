class Assunto {
  int? id;
  String? nome;
  String? graudificuldade;
  String? temponecessario;

  Assunto({this.id, this.nome, this.graudificuldade, this.temponecessario});

  Assunto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    graudificuldade = json['graudificuldade'];
    temponecessario = json['temponecessario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['graudificuldade'] = graudificuldade;
    data['temponecessario'] = temponecessario;
    return data;
  }
}