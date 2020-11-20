import 'package:flutter/foundation.dart';
import 'package:ping_discover_network/ping_discover_network.dart';

class NetworkProvider with ChangeNotifier {
  int _quantidadeIpsMaximo = 0;
  int _quantidadeIpsVerificados = 0;

  String faixaInicial = "";
  String faixaFinal = "";
  String porta = "12345";

  String setSegundoip(String ip) {
    if (ip.split('.').length > 3) {
      faixaFinal = ip.substring(0, ip.lastIndexOf('.') + 1) + "255";
    } else {
      faixaFinal = ip;
    }
    notifyListeners();
  }

  List<String> ipsEncontrados = [];

  double progressBarQuantidade() {
    if (_quantidadeIpsMaximo == 0) return 0;
    return _quantidadeIpsVerificados / _quantidadeIpsMaximo;
  }

  Future buscarConexaoSistema() async {
    _quantidadeIpsVerificados = 0;
    ipsEncontrados.clear();
    notifyListeners();

    const port = 12345;

    final stream = NetworkAnalyzer.discover2(
      '192.168.0',
      port,
      timeout: Duration(milliseconds: 2000),
    );

    _quantidadeIpsMaximo = 255;

    await for (var value in stream) {
      if (value.exists) {
        // print('Found device: ${addr.ip}:$port');
        ipsEncontrados.add(value.ip);
      }
      _quantidadeIpsVerificados++;
      notifyListeners();
    }

    return Future.value(null);
  }

}
