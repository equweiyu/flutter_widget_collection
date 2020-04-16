import 'package:flutter/material.dart';
import 'package:flutter_widget_collection/widget/tab_bar_ex.dart';

class TabBarExScreen extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'AAAAAAAAAAAAAAAAAAAAAAAAA'),
    Tab(text: 'AA'),
    Tab(text: 'AAAAAAA'),
    Tab(text: 'AAAAAAAAAAAAAAA'),
    Tab(text: 'AAAAAAAAAAAAAAAAAAAA'),
    Tab(text: 'AAAAAAAAAAAAAAAAAAAAAAAAA'),
    Tab(text: 'AAA'),
    Tab(text: 'AAAAAAA'),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBarEx(
            tabs: myTabs,
            labelStyle: TextStyle(
              fontSize: 28,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 20,
            ),
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: myTabs.map((Tab tab) {
            final String label = tab.text.toLowerCase();
            return Center(
              child: Text(
                'This is the $label tab',
                style: const TextStyle(fontSize: 36),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
