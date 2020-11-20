import 'package:flutter/material.dart';
import 'package:gourmet_mobile/provider/app_provider.dart';
import 'package:gourmet_mobile/util/app_route.dart';
import 'package:gourmet_mobile/widgets/home_screen/drawer_widget.dart';
import 'package:gourmet_mobile/widgets/home_screen/produto_tile_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/home_screen/bottom_bar_widget.dart';
import '../widgets/home_screen/information_bar_widget.dart';
import '../widgets/home_screen/cliente_widget.dart';
import '../widgets/home_screen/mesa_cartao_pesquisa_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of(context);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text("Comanda"),
        centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(Icons.brightness_medium),
        //   onPressed: () => appProvider.toggleTheme(),
        // ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, AppRoute.SETTINGS),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, AppRoute.PRODUTO),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          ClienteWidget(),
          const SizedBox(height: 8),
          MesaCartaoWidget(),
          const SizedBox(height: 8),
          InformationBarWidget(),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return ProdutoTileWidget(
                  title: index.toString(),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}
