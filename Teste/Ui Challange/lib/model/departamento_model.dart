class Departamento {
  int id;
  int codigo;
  String descricao;
  // List<Null> adicionalDepartamentoControle;

  Departamento({
    this.id,
    this.codigo,
    this.descricao,
    // this.adicionalDepartamentoControle,
  });

  Departamento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codigo = json['codigo'];
    descricao = json['descricao'];
    // if (json['adicionalDepartamentoControle'] != null) {
    //   adicionalDepartamentoControle = new List<Null>();
    //   json['adicionalDepartamentoControle'].forEach((v) {
    //     adicionalDepartamentoControle.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['codigo'] = this.codigo;
    data['descricao'] = this.descricao;
    // if (this.adicionalDepartamentoControle != null) {
    //   data['adicionalDepartamentoControle'] = this.adicionalDepartamentoControle.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
