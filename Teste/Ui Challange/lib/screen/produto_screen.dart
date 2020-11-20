import 'package:flutter/material.dart';
import 'package:gourmet_mobile/model/produto_model.dart';
import 'package:gourmet_mobile/provider/app_provider.dart';
import 'package:gourmet_mobile/provider/network_provider.dart';
import 'package:provider/provider.dart';

class ProdutoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of(context);
    final NetworkProvider networkProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              if (networkProvider.ipsEncontrados.length <= 0) {
                await networkProvider.buscarConexaoSistema();
              }
              appProvider.carregarTodosClientes();
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: appProvider.listaProdutos.length,
        itemBuilder: (ctx, index) {
          Produto produto = appProvider.listaProdutos[index];
          return ListTile(
            dense: true,
            title: Text(produto.descricao),
            subtitle: Text(produto.codigoInterno),
            trailing: Text("\$ " + produto.valorUnitarioComercial.toStringAsFixed(2)),
          );
        },
      ),
    );
  }
}
