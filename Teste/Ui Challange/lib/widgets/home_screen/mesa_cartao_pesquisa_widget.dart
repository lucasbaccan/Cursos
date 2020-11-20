import 'package:flutter/material.dart';

class MesaCartaoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Mesa',
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
                    Icons.search,
                    color: Theme.of(context).accentColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                  ),
                  onTap: () {}, // button pressed
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Cartão',
                isDense: true, // Ajuda a deixar o campo pequeno
                contentPadding: const EdgeInsets.all(8), // Ajuda a deixar o campo pequeno
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
          ),
          const SizedBox(width: 5),
          SizedBox.fromSize(
            size: const Size(35, 35),
            child: ClipOval(
              child: Material(
                color: Theme.of(context).accentColor, // button color
                child: InkWell(
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).accentColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                  ),
                  onTap: () {}, // button pressed
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
