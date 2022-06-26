/**
 * This file contain Code Of Batch Used On Cart
 */
import 'package:flutter/material.dart';
class BBadge extends StatelessWidget {
  //A badge widget used on Cart
  const BBadge({
    Key? key,
    required this.child,
    required this.value,
    this.color,
  }) : super(key: key);

  final Widget child;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
         // left: 0,
          top: -2,
          left: -2,
        //  bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(1.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style:const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}
