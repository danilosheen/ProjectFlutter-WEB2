class Encontro {
  int? id;
  String? qtdalunos;
  String? data;
  String? assunto;

  Encontro({this.id, this.qtdalunos, this.data, this.assunto});

  Encontro.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qtdalunos = json['qtdalunos'];
    data = json['data'];
    assunto = json['assunto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['qtdalunos'] = qtdalunos;
    data['data'] = data;
    data['assunto'] = assunto;
    return data;
  }
}