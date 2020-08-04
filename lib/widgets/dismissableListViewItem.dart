import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imageshapecalculator/models/evaluateLayers.dart';
import 'package:imageshapecalculator/models/layerData.dart';
import 'package:imageshapecalculator/models/layers.dart';
import 'package:provider/provider.dart';

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
            Layers layers = Provider.of<Layers>(context, listen: false);
            evaluateLayers(layers);
          },
          onDoubleTap: () {
            this.widget.onCopy(this.widget.index, widget);
          },
          child: (this.isExpanded) ? widget.expandedChild : widget.child),
      background:
          getDeleteIcon(MainAxisAlignment.start, EdgeInsets.only(left: 20.0)),
      secondaryBackground:
          getDeleteIcon(MainAxisAlignment.end, EdgeInsets.only(right: 20.0)),
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) =>
          this.widget.onDismissed(this.widget.index),
      direction: DismissDirection.horizontal,
    );
  }

  Container getDeleteIcon(
      MainAxisAlignment mainAxisAlignment, EdgeInsets edgeInsets) {
    return Container(
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: <Widget>[
          FaIcon(
            FontAwesomeIcons.trash,
            size: 50,
          ),
        ],
      ),
      padding: edgeInsets,
    );
  }
}
