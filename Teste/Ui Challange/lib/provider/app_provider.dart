import 'package:flutter/foundation.dart';
import 'package:gourmet_mobile/model/produto_model.dart';
import 'package:gourmet_mobile/model/usuario_model.dart';
import 'package:gourmet_mobile/service/api_service.dart';

class AppProvider with ChangeNotifier {
  bool lightTheme = true;

  String ip = "";
  String porta = "";

  void toggleTheme() {
    lightTheme = !lightTheme;
    notifyListeners();
  }

  // ---------------------------------------------

  Usuario usuarioLogado;

  Future<bool> realizarLogin(String usuario, String senha) async {
    // isLoading = true;
    // isError = false;
    // notifyListeners();

    return await ApiService.realizarLogin(ip, porta, usuario, senha).then((value) {
      if (value == null) {
        print("ERRO: $value");
        // isError = true;
        // notifyListeners();
        return Future.value(false);
      } else {
        usuarioLogado = value;
        notifyListeners();
        return Future.value(true);
      }
    });
  }

// ---------------------------------------------

  List<Produto> listaProdutos = [];

  Future<void> carregarTodosClientes() async {
    // isLoading = true;
    // isError = false;
    // notifyListeners();

    await ApiService.carregarProdutos(ip, porta).then((value) {
      if (value == null) {
        print("ERRO: $value");
        // isError = true;
        // notifyListeners();
      } else {
        listaProdutos = value;
        notifyListeners();
      }
    });
    // isLoading = false;
    return Future.value(null);
  }
}
