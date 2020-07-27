import 'package:flutter/material.dart';

class DismissableListViewItem extends StatefulWidget {
  final Widget child;
  final Widget expandedChild;
  final Function onDismissed;
  final bool isInitiallyExpanded;
  int index;
  DismissableListViewItem({
    Key key,
    @required this.child,
    @required this.expandedChild,
    @required this.onDismissed,
    @required this.index,
    this.isInitiallyExpanded = false,
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
          },
          child: (this.isExpanded) ? widget.expandedChild : widget.child),
      background: Container(color: Colors.lightGreenAccent),
      key: UniqueKey(),
      onDismissed: (direction) => this.widget.onDismissed(this.widget.index),
    );
  }
}
