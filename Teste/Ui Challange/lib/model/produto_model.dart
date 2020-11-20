import 'departamento_model.dart';

class Produto {
  int id;
  String codigoInterno;
  String descricao;
  double valorUnitarioComercial;
  Departamento departamento;
  // List<Null> itemGrupoImpressao;
  bool temAdicional;
  // List<Null> adicionalProdutoControle;

  Produto({
    this.id,
    this.codigoInterno,
    this.descricao,
    this.valorUnitarioComercial,
    this.departamento,
    // this.itemGrupoImpressao,
    this.temAdicional,
    // this.adicionalProdutoControle,
  });

  Produto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codigoInterno = json['codigoInterno'];
    descricao = json['descricao'];
    valorUnitarioComercial = json['valorUnitarioComercial'];
    departamento = json['departamento'] != null ? new Departamento.fromJson(json['departamento']) : null;
    // if (json['itemGrupoImpressao'] != null) {
    //   itemGrupoImpressao = new List<Null>();
    //   json['itemGrupoImpressao'].forEach((v) {
    //     itemGrupoImpressao.add(new Null.fromJson(v));
    //   });
    // }
    temAdicional = json['temAdicional'];
    // if (json['adicionalProdutoControle'] != null) {
    //   adicionalProdutoControle = new List<Null>();
    //   json['adicionalProdutoControle'].forEach((v) {
    //     adicionalProdutoControle.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['codigoInterno'] = this.codigoInterno;
    data['descricao'] = this.descricao;
    data['valorUnitarioComercial'] = this.valorUnitarioComercial;
    if (this.departamento != null) {
      data['departamento'] = this.departamento.toJson();
    }
    // if (this.itemGrupoImpressao != null) {
    //   data['itemGrupoImpressao'] = this.itemGrupoImpressao.map((v) => v.toJson()).toList();
    // }
    data['temAdicional'] = this.temAdicional;
    // if (this.adicionalProdutoControle != null) {
    //   data['adicionalProdutoControle'] = this.adicionalProdutoControle.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
