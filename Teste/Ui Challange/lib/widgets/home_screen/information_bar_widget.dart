import 'package:flutter/material.dart';

class InformationBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Itens",
              style: TextStyle(
                color: Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              ),
            ),
            Text(
              "Produtos",
              style: TextStyle(
                color: Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              ),
            ),
            Text(
              "\$0.00",
              style: TextStyle(
                color: Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
