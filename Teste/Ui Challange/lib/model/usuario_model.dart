class Usuario {
  int id;
  String nome;
  String usuario;
  String senha;
  // Empresa empresa;

  Usuario({
    this.id,
    this.nome,
    this.usuario,
    this.senha,
    // this.empresa,
  });

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    usuario = json['usuario'];
    senha = json['senha'];
    // empresa = json['empresa'] != null ? new Empresa.fromJson(json['empresa']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['usuario'] = this.usuario;
    data['senha'] = this.senha;
    // if (this.empresa != null) {
    //   data['empresa'] = this.empresa.toJson();
    // }
    return data;
  }
}

class Empresa {
  int id;

  Empresa({this.id});

  Empresa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
