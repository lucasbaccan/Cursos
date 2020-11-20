import 'package:flutter/material.dart';
import 'package:gourmet_mobile/provider/app_provider.dart';
import 'package:gourmet_mobile/provider/network_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _faixaInicialController = TextEditingController();
  final TextEditingController _faixaFinalController = TextEditingController();
  final TextEditingController _faixaPortaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _faixaInicialController.text = Provider.of<NetworkProvider>(context, listen: false).faixaInicial;
    _faixaFinalController.text = Provider.of<NetworkProvider>(context, listen: false).faixaFinal;
    _faixaPortaController.text = Provider.of<NetworkProvider>(context, listen: false).porta;
  }

  @override
  void dispose() {
    super.dispose();
    _faixaInicialController.dispose();
    _faixaFinalController.dispose();
    _faixaPortaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of(context);
    final NetworkProvider networkProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Configuração"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Conexão atual',
                      isDense: true, // Ajuda a deixar o campo pequeno
                      contentPadding: const EdgeInsets.all(8), // Ajuda a deixar o campo pequeno
                      labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox.fromSize(
                  size: const Size(35, 35), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Theme.of(context).accentColor, // button color
                      child: InkWell(
                        child: Icon(
                          Icons.check,
                          color: Theme.of(context).accentColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                        ),
                        onTap: () {}, // button pressed
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _faixaInicialController,
                    onChanged: (value) => {
                      if (value.split('.').length > 3)
                        {
                          _faixaFinalController.text = value.substring(0, value.lastIndexOf('.') + 1) + "255",
                        }
                      else
                        {
                          _faixaFinalController.text = value,
                        }
                    },
                    onEditingComplete: () {
                      _faixaInicialController.text =
                          _faixaInicialController.text.substring(0, _faixaInicialController.text.lastIndexOf('.') + 1) +
                              "0";
                    },
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Faixa de IP inicial',
                      // suffixText: ".0",
                      suffixStyle: TextStyle(),
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                      ),
                      isDense: true, // Ajuda a deixar o campo pequeno
                      contentPadding: const EdgeInsets.all(8), // Ajuda a deixar o campo pequeno
                      labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _faixaFinalController,
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Faixa de IP final',
                      isDense: true, // Ajuda a deixar o campo pequeno
                      contentPadding: const EdgeInsets.all(8), // Ajuda a deixar o campo pequeno
                      labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _faixaPortaController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Porta',
                      isDense: true, // Ajuda a deixar o campo pequeno
                      contentPadding: const EdgeInsets.all(8), // Ajuda a deixar o campo pequeno
                      labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            LinearProgressIndicator(
              value: networkProvider.progressBarQuantidade(),
              minHeight: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    onPressed: () async {
                      await networkProvider.buscarConexaoSistema();
                      appProvider.ip = networkProvider.ipsEncontrados[0];
                      appProvider.porta = "12345";
                    },
                    child: Text(
                      "Buscar conexão com o sistema",
                      style: TextStyle(
                        color: Theme.of(context).accentColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                      ),
                    ),
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: networkProvider.ipsEncontrados.length,
                itemBuilder: (ctx, index) {
                  String ip = networkProvider.ipsEncontrados[index];
                  return Text("${ip}");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// const port = 12345;
// final stream = NetworkAnalyzer.discover2(
//   '192.168.0',
//   port,
//   // timeout: Duration(milliseconds: 5000),
// );

// int found = 0;
// stream.listen((NetworkAddress addr) {
//   // print('${addr.ip}:$port');
//   if (addr.exists) {
//     found++;
//     print('Found device: ${addr.ip}:$port');
//   } else {
//     print('NOT Found device: ${addr.ip}:$port');
//   }
// }).onDone(() => print('Finish. Found $found device(s)'));
// }
