import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_collection/widget/popup_toolbar_button.dart';

class PopupToolbarButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
                child: buildPopupMenuButtonEx(), alignment: Alignment.topLeft),
            Align(
                child: buildPopupMenuButtonEx(),
                alignment: Alignment.topCenter),
            Align(
                child: buildPopupMenuButtonEx(), alignment: Alignment.topRight),
            Align(
                child: buildPopupMenuButtonEx(),
                alignment: Alignment.centerLeft),
            Align(child: buildPopupMenuButtonEx(), alignment: Alignment.center),
            Align(
                child: buildPopupMenuButtonEx(),
                alignment: Alignment.centerRight),
            Align(
                child: buildPopupMenuButtonEx(),
                alignment: Alignment.bottomLeft),
            Align(
                child: buildPopupMenuButtonEx(),
                alignment: Alignment.bottomCenter),
            Align(
                child: buildPopupMenuButtonEx(),
                alignment: Alignment.bottomRight),
          ],
        ),
      ),
    );
  }

  Widget buildPopupMenuButtonEx() {
    return WShowToolbarButton(
      childBuilder: (context, show) => Text(
        'data',
        style: TextStyle(color: show ? Colors.black : Colors.blue),
      ),
      tooleBarBuilder: (context, tool) => Wrap(
        children: <Widget>[
          CupertinoButton(child: Text('data'), onPressed: () {}),
        ],
      ),
    );
  }
}
