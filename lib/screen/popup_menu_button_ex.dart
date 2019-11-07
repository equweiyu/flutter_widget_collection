import 'package:flutter/material.dart';
import 'package:flutter_widget_collection/widget/popup_menu_button_ex.dart';

class PopupMenuButtonExScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PopupMenuButtonExScreen'),
      ),
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

  PopupMenuButtonEx buildPopupMenuButtonEx() {
    return PopupMenuButtonEx(
      icon: Icon(
        Icons.menu,
      ),
      itemBuilder: (context) => <PopupMenuEntry>[
        const PopupMenuItem(
          child: Text('=.='),
        ),
        const PopupMenuItem(
          child: Text('0.0'),
        ),
      ],
    );
  }
}
