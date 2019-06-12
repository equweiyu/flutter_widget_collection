import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyboardExpandScreen extends StatefulWidget {
  @override
  _KeyboardExpandScreenState createState() => _KeyboardExpandScreenState();
}

class _KeyboardExpandScreenState extends State<KeyboardExpandScreen> {
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  List<String> _dataSource = [];
  List<String> _helpSource = [
    '快捷输入 1',
    '快捷输入 2',
    '快捷输入 3',
    '快捷输入 4',
    '快捷输入 5',
    '快捷输入 6',
    '快捷输入 7',
    '快捷输入 8',
  ];
  bool _hideMenu = true;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('keyboard'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  return Divider(
                    indent: 15.0,
                  );
                } else {
                  return ListTile(
                    title: Text('${_dataSource[index ~/ 2]}'),
                  );
                }
              },
              itemCount: _dataSource.length * 2,
            ),
          ),
          Container(
            height: 50.0,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    showMenu();
                  },
                ),
                Expanded(
                    child: TextField(
                  controller: _textEditingController,
                  onTap: () {
                    if (!_hideMenu) {
                      setState(() {
                        _hideMenu = true;
                      });
                    }
                  },
                )),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    add();
                  },
                ),
              ],
            ),
          ),
          _hideMenu
              ? SizedBox()
              : TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: '搜索',
                      border: InputBorder.none),
                ),
          _hideMenu
              ? SizedBox()
              : Container(
                  height: 150,
                  child: ListView(
                    children: _helpSource
                        .where((v) => v.contains(_searchController.text))
                        .map((f) => ListTile(
                              title: Text(f),
                              onTap: () {
                                setState(() {
                                  _dataSource.add(f);
                                });
                              },
                            ))
                        .toList(),
                  ),
                )
        ],
      ),
    );
  }

  void showMenu() {
    setState(() {
      _hideMenu = !_hideMenu;
    });
  }

  void add() {
    setState(() {
      if (_textEditingController.text.isNotEmpty) {
        _dataSource.add(_textEditingController.text);
      }
      _textEditingController.text = '';
    });
  }
}
