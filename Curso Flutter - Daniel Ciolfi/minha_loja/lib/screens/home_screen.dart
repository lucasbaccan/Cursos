import 'package:flutter/material.dart';
import 'package:minha_loja/tabs/home_tab.dart';
import 'package:minha_loja/tabs/products_tab.dart';
import 'package:minha_loja/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pagaController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pagaController,
      children: <Widget>[
        Scaffold(
          drawer: CustomDrawer(_pagaController),
          body: HomeTab(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pagaController),
          body: ProductsTab(),
        ),
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.green,
        )
      ],
    );
  }
}
