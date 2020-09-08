import 'package:flutter/material.dart';
import 'package:shop/utils/app_route.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Bem vindo usuário'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Loja'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoute.HOME);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoute.ORDERS);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerencia Produtos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoute.PRODUCTS);
            },
          ),
        ],
      ),
    );
  }
}
