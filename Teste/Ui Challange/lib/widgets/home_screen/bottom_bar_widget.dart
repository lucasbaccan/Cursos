import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return BottomAppBar(
    //   color: Theme.of(context).primaryColor,
    //   shape: const CircularNotchedRectangle(),
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 2),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         const SizedBox(width: 8),
    //         Flexible(
    //           flex: 3,
    //           fit: FlexFit.tight,
    //           child: RaisedButton(
    //             child: const Text('Cancelar'),
    //             color: Colors.red,
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(6.0),
    //             ),
    //             onPressed: () {},
    //           ),
    //         ),
    //         const SizedBox(width: 8),
    //         Flexible(
    //           flex: 4,
    //           fit: FlexFit.tight,
    //           child: RaisedButton(
    //             child: const Text('Salvar'),
    //             color: Colors.green,
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(6.0),
    //             ),
    //             onPressed: () {},
    //           ),
    //         ),
    //         const SizedBox(width: 85)
    //       ],
    //     ),
    //   ),
    // );
    return BottomAppBar(
      color: Theme.of(context).primaryColor,
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Row(
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.cancel,
                        color: Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Cancelar",
                        style: TextStyle(
                            color:
                                Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white),
                      ),
                    ],
                  ),
                ),
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.save,
                        color: Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Salvar",
                        style: TextStyle(
                            color:
                                Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white),
                      ),
                    ],
                  ),
                ),
                // borderRadius: BorderRadius.circular(10),
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              // IconButton(
              //   color: Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              //   icon: Icon(Icons.cancel),
              //   onPressed: () {},
              // ),
              // IconButton(
              //   color: Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              //   icon: Icon(Icons.save),
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
