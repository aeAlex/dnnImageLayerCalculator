import 'package:flutter/material.dart';

class DismissableListViewItem extends StatefulWidget {
  final Widget child;
  final Function onDismissed;
  int index;
  DismissableListViewItem({
    Key key,
    @required this.child,
    @required this.onDismissed,
    @required this.index,
  }) : super(key: key);

  @override
  _DismissableListViewItemState createState() =>
      _DismissableListViewItemState();
}

class _DismissableListViewItemState extends State<DismissableListViewItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: widget.child,
      background: Container(color: Colors.lightGreenAccent),
      key: UniqueKey(),
      onDismissed: (direction) => this.widget.onDismissed(this.widget.index),
    );
  }
}
