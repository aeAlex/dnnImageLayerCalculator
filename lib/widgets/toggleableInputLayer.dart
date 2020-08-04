import 'package:flutter/material.dart';
import 'package:imageshapecalculator/models/ImageData.dart';
import 'package:imageshapecalculator/models/evaluateLayers.dart';
import 'package:imageshapecalculator/models/layers.dart';
import 'package:imageshapecalculator/widgets/expandedInputImageCard.dart';
import 'package:provider/provider.dart';

import 'inputImageCard.dart';

class ToggleableInputLayer extends StatefulWidget {
  final bool isInitiallyExtended;

  final ImageData inputLayerData;

  const ToggleableInputLayer({
    Key key,
    this.isInitiallyExtended = true,
    @required this.inputLayerData,
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
      child: (this.isExtended)
          ? ExpandedInputImageCard(inputLayerData: this.widget.inputLayerData)
          : InputImageCard(inputLayerData: this.widget.inputLayerData),
      onTap: () {
        setState(() {
          this.isExtended = !this.isExtended;
        });
        // reevaluate the layers after tap
        Layers layers = Provider.of<Layers>(context, listen: false);
        evaluateLayers(layers);
      },
    );
  }
}
