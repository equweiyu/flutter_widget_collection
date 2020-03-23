import 'package:flutter/material.dart';
import 'package:flutter_widget_collection/screen/popup_menu_button_ex.dart';
import 'package:flutter_widget_collection/screen/popup_toolbar_button.dart';
import 'package:flutter_widget_collection/screen/tab_bar_ex.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomeScreen(),
      theme: ThemeData.light(),
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
            title: Text('TabBarExScreen'),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => TabBarExScreen())),
          ),
          ListTile(
            title: Text('PopupToolbarButton'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PopupToolbarButtonPage())),
          ),
          ListTile(
            title: Text('EnsureVisibleWhenFocused // todo'),
          ),
        ],
      ),
    );
  }
}
