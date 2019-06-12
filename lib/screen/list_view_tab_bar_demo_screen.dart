import 'package:flutter/material.dart';

class ListViewTabBarDemoScreen extends StatefulWidget {
  @override
  _ListViewTabBarDemoScreenState createState() => _ListViewTabBarDemoScreenState();
}

class _ListViewTabBarDemoScreenState extends State<ListViewTabBarDemoScreen>
    with SingleTickerProviderStateMixin {
  List<String> tabs = ['=。=', '-，-', '0.0'];
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  Widget _buildTabView(String text) {
    return ListView(
      children: <Widget>[
        ExpansionTile(
          title: Text('1 ($text)'),
          children: <Widget>[
            Divider(
              indent: 15.0,
            ),
            ListTile(
              title: Text('1'),
            ),
            Divider(
              indent: 15.0,
            ),
            ListTile(
              title: Text('2'),
            ),
          ],
        ),
        ExpansionTile(
          title: Text('2'),
          children: <Widget>[
            Divider(
              indent: 15.0,
            ),
            ListTile(
              title: Text('1'),
            ),
            Divider(
              indent: 15.0,
            ),
            ListTile(
              title: Text('2'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 60.0,
            child: TabBar(
              controller: _tabController,
              tabs: tabs
                  .map((f) => Tab(
                        child: Text(
                          f,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Container(
            color: Colors.white,
            height: 312.0,
            child: TabBarView(
              controller: _tabController,
              children: tabs.map((f) => _buildTabView(f)).toList(),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.pink,
              child: Center(
                  child: Text(
                '我来组成下面-。。-',
                style: TextStyle(color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}
