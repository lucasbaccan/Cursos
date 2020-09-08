import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/utils/app_route.dart';
import 'package:shop/widgets/app-drawer.dart';
import 'package:shop/widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Products productsData = Provider.of<Products>(context);
    List<Product> products = productsData.itens;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerencia Produtos'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoute.PRODUCTS_FORM);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (ctx, i) => Column(
            children: <Widget>[ProductItem(products[i]), Divider()],
          ),
        ),
      ),
    );
  }
}
