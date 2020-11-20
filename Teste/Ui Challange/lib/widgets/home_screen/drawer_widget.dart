import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  Widget _criarListTile(BuildContext ctx, String titulo) {
    return Column(
      children: [
        ListTile(
            title: Text(titulo),
            onTap: () {
              var flushbar = Flushbar(
                message: titulo,
                duration: Duration(seconds: 3),
                flushbarStyle: FlushbarStyle.FLOATING,
                margin: EdgeInsets.all(8),
                borderRadius: 8,
                isDismissible: true,
              );
              flushbar..show(ctx);
            }),
        Divider(height: 0, thickness: 1)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Drawer(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Menu"),
            centerTitle: true,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _criarListTile(context, "Comandas"),
              _criarListTile(context, "Mesas"),
              _criarListTile(context, "Cartões"),
            ],
          ),
        ),
      ),
    );
  }
}
