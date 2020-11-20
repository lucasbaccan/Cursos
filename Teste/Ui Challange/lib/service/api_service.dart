import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:gourmet_mobile/model/produto_model.dart';
import 'package:gourmet_mobile/model/usuario_model.dart';

class ApiService {
  // Login
  static Future<dynamic> realizarLogin(String ip, String port, String usuario, String senha) async {
    BaseOptions options = new BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000, // 60 seconds
      headers: {
        'Content-Type': "application/json; charset=UTF-8",
        'username': usuario,
        'password': md5.convert(utf8.encode(senha)).toString(),
      },
    );
    Dio dio = new Dio(options);

    return await dio.get("http://" + ip + ":" + port + "/login").then((response) {
      // print("Response: $response");
      Usuario user = Usuario.fromJson(json.decode(response.data));
      return Future.value(user);
    }).catchError((onError) {
      print("ERRO: $onError");
      return Future.value(null);
    });
  }

  // Carregar todos os protudos
  static Future<dynamic> carregarProdutos(String ip, String port) async {
    List<Produto> listProduto = [];

    BaseOptions options = new BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000, // 60 seconds
    );
    Dio dio = new Dio(options);

    return await dio.get("http://" + ip + ":" + port + "/produto").then((response) {
      // print("Response: $response");
      listProduto = response.data.map<Produto>((json) => Produto.fromJson(json)).toList();
      // listCliente.sort((a, b) => a.name.compareTo(b.name));
      return Future.value(listProduto);
    }).catchError((onError) {
      print("ERRO: $onError");
      return Future.value(null);
    });
  }
}
