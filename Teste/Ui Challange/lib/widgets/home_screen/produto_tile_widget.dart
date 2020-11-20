import 'dart:wasm';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class ProdutoTileWidget extends StatefulWidget {
  final String title;

  ProdutoTileWidget({
    this.title,
  });

  @override
  _ProdutoTileWidgetState createState() => _ProdutoTileWidgetState();
}

class _ProdutoTileWidgetState extends State<ProdutoTileWidget> {
  int quantidade = 1;

  @override
  Widget build(BuildContext context) {
    var faker = new Faker();

    double price = faker.randomGenerator.decimal(scale: 2) + faker.randomGenerator.integer(25, min: 0);

    return Container(
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [Icon(Icons.add_circle), Text("Adicionar")],
              ),
            ),
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: [Icon(Icons.remove_circle), Text("Remover")],
              ),
            ),
          ),
        ),
        dismissThresholds: {
          DismissDirection.startToEnd: 0.2,
          DismissDirection.endToStart: 0.2,
        },
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            print("Esquerda Direita");
            setState(() {
              quantidade++;
            });
          } else {
            print("Direita Esquerda");
            if (quantidade == 1) return Future.value(true);
            setState(() {
              quantidade--;
            });
          }
          return Future.value(false);
        },
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: IconButton(
            icon: Icon(Icons.exposure_plus_1),
            onPressed: () {
              setState(() {
                quantidade++;
              });
            },
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("X $quantidade"),
              IconButton(
                icon: Icon(Icons.exposure_minus_1),
                onPressed: () {
                  setState(() {
                    quantidade--;
                  });
                },
              ),
            ],
          ),
          // leading: CircleAvatar(
          //   child: Text("$quantidade"),
          // ),
          title: Text(faker.food.dish()),
          subtitle: Text("\$ ${price.toStringAsFixed(2)}"),
          dense: true,
        ),
      ),
    );
  }
}
