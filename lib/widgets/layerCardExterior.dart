import 'package:flutter/material.dart';

class LayerCardExterior extends StatelessWidget {
  final Widget child;
  final Color color;
  final double height;

  const LayerCardExterior(
      {Key key,
      @required this.child,
      @required this.color,
      @required this.height})
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
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(6.0),
      height: height,
    );
  }
}
