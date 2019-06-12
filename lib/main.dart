import 'package:flutter/material.dart';
import 'package:flutter_widget_collection/screen/keyboard_expand_screen.dart';
import 'package:flutter_widget_collection/screen/label_screen.dart';
import 'package:flutter_widget_collection/screen/list_view_tab_bar_demo_screen.dart';

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
      body: Column(
        children: <Widget>[
          Center(
            child: RawMaterialButton(
              child: Text('标签'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LabelScreen()));
              },
            ),
          ),
          Center(
            child: RawMaterialButton(
              child: Text('listview tabbar'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ListViewTabBarDemoScreen()));
              },
            ),
          ),
          Center(
            child: RawMaterialButton(
              child: Text('keybord expand'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            KeyboardExpandScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
