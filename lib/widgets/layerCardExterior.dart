import 'package:flutter/material.dart';

class LayerCardExterior extends StatelessWidget {
  final Widget child;
  final Color color;

  const LayerCardExterior({Key key, @required this.child, @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1.0, 2.0),
            blurRadius: 2.0,
          ),
        ],
      ),
      height: 70.0,
      margin: const EdgeInsets.only(bottom: 8.0),
    );
  }
}
