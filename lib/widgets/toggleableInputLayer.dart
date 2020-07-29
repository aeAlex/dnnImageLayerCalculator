import 'package:flutter/material.dart';
import 'package:imageshapecalculator/widgets/expandedInputImageCard.dart';

import 'inputImageCard.dart';

class ToggleableInputLayer extends StatefulWidget {
  final bool isInitiallyExtended;

  const ToggleableInputLayer({
    Key key,
    this.isInitiallyExtended = true,
  }) : super(key: key);

  @override
  _ToggleableInputLayerState createState() => _ToggleableInputLayerState();
}

class _ToggleableInputLayerState extends State<ToggleableInputLayer> {
  bool isExtended;

  @override
  void initState() {
    super.initState();

    this.isExtended = this.widget.isInitiallyExtended;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: (this.isExtended) ? ExpandedInputImageCard() : InputImageCard(),
      onTap: () {
        setState(() {
          this.isExtended = !this.isExtended;
        });
      },
    );
  }
}
