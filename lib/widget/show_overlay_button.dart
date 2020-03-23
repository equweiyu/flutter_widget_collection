import 'package:flutter/material.dart';

class ShowOverlayButon extends StatelessWidget {
  final Widget child;

  const ShowOverlayButon({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showOverlay(context),
      child: child,
    );
  }

  void _showOverlay(BuildContext context) {
    final RenderBox button = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(button.size.bottomLeft(Offset.zero),
            ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Container(
        child: GestureDetector(
          onTap: () {
            overlayEntry?.remove();
          },
          child: Container(
            color: Colors.white70,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: position.top,
                  right: position.right,
                  child: Material(
                    elevation: 8.0,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 200.0,
                            height: 44.0,
                            color: Colors.red,
                          ),
                          Container(
                            width: 100.0,
                            height: 44.0,
                            color: Colors.blue,
                          ),
                          Container(
                            width: 100.0,
                            height: 44.0,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    overlayState.insert(overlayEntry);
  }
}
