import 'package:flutter/material.dart';
import 'package:imageshapecalculator/main.dart';
import 'package:imageshapecalculator/models/evaluateLayers.dart';
import 'package:imageshapecalculator/models/layerData.dart';
import 'package:imageshapecalculator/models/layers.dart';
import 'package:provider/provider.dart';

import 'getDeleteIcon.dart';

class DismissableListViewItem extends StatefulWidget {
  final Widget child;
  final Widget expandedChild;
  final Function onDismissed;
  final Function onCopy;
  final bool isInitiallyExpanded;
  int index;
  final LayerData layerData;

  DismissableListViewItem({
    Key key,
    @required this.child,
    @required this.expandedChild,
    @required this.onDismissed,
    @required this.index,
    @required this.layerData,
    this.isInitiallyExpanded = false,
    @required this.onCopy,
  }) : super(key: key);

  @override
  _DismissableListViewItemState createState() =>
      _DismissableListViewItemState();
}

class _DismissableListViewItemState extends State<DismissableListViewItem> {
  bool isExpanded;

  @override
  void initState() {
    super.initState();

    this.isExpanded = this.widget.isInitiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: GestureDetector(
          onTap: () {
            print("tapped");
            setState(() {
              this.isExpanded = !this.isExpanded;
            });
            // reevaluate the layers after tap
            ProviderData providerData =
                Provider.of<ProviderData>(context, listen: false);
            Layers layers = providerData.layers;
            evaluateLayers(layers);
          },
          onDoubleTap: () {
            this.widget.onCopy(this.widget.index, widget);
          },
          child: (this.isExpanded) ? widget.expandedChild : widget.child),
      background: getDeleteIcon(
          MainAxisAlignment.start, EdgeInsets.only(left: 20.0), 50),
      secondaryBackground: getDeleteIcon(
          MainAxisAlignment.end, EdgeInsets.only(right: 20.0), 50),
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) =>
          this.widget.onDismissed(this.widget.index),
      direction: DismissDirection.horizontal,
    );
  }
}
