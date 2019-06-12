import 'package:flutter/material.dart';

class LabelScreen extends StatefulWidget {
  @override
  _LabelScreenState createState() => _LabelScreenState();
}

class _LabelScreenState extends State<LabelScreen> {
  List<String> _tags = ['action1', 'action2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('标签'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Wrap(
            children: _tags
                .map((f) => ActionChip(
                      label: Text(f),
                      onPressed: () {
                        setState(() {});
                      },
                    ))
                .toList(),
          ),
        ));
  }
}

class ActionView extends StatefulWidget {
  final Widget child;

  const ActionView({Key key, this.child}) : super(key: key);
  @override
  _ActionViewState createState() => _ActionViewState();
}

class _ActionViewState extends State<ActionView> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
