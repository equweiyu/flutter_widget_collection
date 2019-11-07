import 'package:flutter/material.dart';
import 'package:flutter_widget_collection/screen/popup_menu_button_ex.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Collection'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('PopupMenuButtonExScreen'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PopupMenuButtonExScreen())),
          ),
          ListTile(
            title: Text('EnsureVisibleWhenFocused // todo'),
          ),
        ],
      ),
    );
  }
}
