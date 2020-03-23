import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DefaultPreferredSizeWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final double width;
  final double height;
  final Widget child;
  const DefaultPreferredSizeWidget(
      {Key key, this.width, this.height = kToolbarHeight, this.child})
      : super(key: key);
  @override
  Size get preferredSize {
    return Size(width, height);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height, child: child);
  }
}
