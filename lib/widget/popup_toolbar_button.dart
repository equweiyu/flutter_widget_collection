import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const Size _kToolbarArrowSize = Size(14.0, 7.0);

const Radius _kToolbarBorderRadius = Radius.circular(4);

const Color _kToolbarDividerColor = Color(0xFF474747);

const double _kToolbarScreenPadding = 8.0;

class WShowToolbarButton extends StatefulWidget {
  final Color color;
  final bool isArrowPointingDown;
  final Widget Function(BuildContext context, bool show) childBuilder;
  final Widget Function(BuildContext context, OverlayEntry tool)
      tooleBarBuilder;

  const WShowToolbarButton({
    Key key,
    this.isArrowPointingDown = true,
    this.color,
    this.tooleBarBuilder,
    this.childBuilder,
  }) : super(key: key);

  @override
  _WShowToolbarButtonState createState() => _WShowToolbarButtonState();
}

class _WShowToolbarButtonState extends State<WShowToolbarButton> {
  static const Duration _kFadeDuration = Duration(milliseconds: 150);
  OverlayState _overlay;
  OverlayEntry _toolbar;
  AnimationController _toolbarController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.childBuilder(context, _toolbar != null),
      onTap: () {
        setState(() {
          showToolbar();
        });
      },
    );
  }

  Widget buildToolbar() {
    final RenderBox button = context.findRenderObject();
    final EdgeInsets arrowPadding = widget.isArrowPointingDown
        ? EdgeInsets.only(bottom: _kToolbarArrowSize.height)
        : EdgeInsets.only(top: _kToolbarArrowSize.height);
    return _Toolbar(
      boxRect: Rect.fromPoints(button.localToGlobal(Offset.zero),
          button.localToGlobal(button.size.bottomRight(Offset.zero))),
      isArrowPointingDown: widget.isArrowPointingDown,
      child: DecoratedBox(
        decoration: BoxDecoration(color: _kToolbarDividerColor),
        child: Padding(
          padding: arrowPadding,
          child: widget.tooleBarBuilder(context, _toolbar),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final overlay = Overlay.of(context, debugRequiredFor: widget);
    if (_overlay != overlay) {
      hideToolbar();
      _overlay = overlay;
      _toolbarController?.dispose();
      _toolbarController = null;
    }
    if (_toolbarController == null) {
      _toolbarController = AnimationController(
        duration: _kFadeDuration,
        vsync: _overlay,
      );
    }

    _toolbar?.markNeedsBuild();
  }

  @override
  void dispose() {
    hideToolbar();
    _toolbarController.dispose();
    _toolbarController = null;
    super.dispose();
  }

  void hideToolbar() {
    _toolbar?.remove();
    _toolbar = null;
    _toolbarController?.stop();
  }

  void showToolbar() {
    if (widget.tooleBarBuilder == null) return;
    final toolbarOpacity = _toolbarController.view;
    _toolbar = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          setState(() {
            hideToolbar();
          });
        },
        behavior: HitTestBehavior.opaque,
        child: FadeTransition(
          opacity: toolbarOpacity,
          child: buildToolbar(),
        ),
      ),
    );
    _overlay.insert(_toolbar);
    _toolbarController.forward(from: 0.0);
  }
}

class _Toolbar extends SingleChildRenderObjectWidget {
  final bool _isArrowPointingDown;
  final Rect _boxRect;

  const _Toolbar({
    Key key,
    bool isArrowPointingDown,
    Widget child,
    Rect boxRect,
  })  : _isArrowPointingDown = isArrowPointingDown,
        _boxRect = boxRect,
        super(key: key, child: child);

  @override
  _ToolbarRenderBox createRenderObject(BuildContext context) =>
      _ToolbarRenderBox(_isArrowPointingDown, _boxRect, null);

  @override
  void updateRenderObject(
      BuildContext context, _ToolbarRenderBox renderObject) {
    renderObject
      ..boxRect = _boxRect
      ..isArrowPointingDown = _isArrowPointingDown;
  }
}

class _ToolbarParentData extends BoxParentData {
  double arrowXOffsetFromCenter;
  @override
  String toString() =>
      'offset=$offset, arrowXOffsetFromCenter=$arrowXOffsetFromCenter';
}

class _ToolbarRenderBox extends RenderShiftedBox {
  bool _isArrowPointingDown;

  Rect _boxRect;

  _ToolbarRenderBox(
    this._isArrowPointingDown,
    this._boxRect,
    RenderBox child,
  ) : super(child);

  set boxRect(Rect value) {
    if (_boxRect == value) {
      return;
    }
    _boxRect = value;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  set isArrowPointingDown(bool value) {
    if (_isArrowPointingDown == value) {
      return;
    }
    _isArrowPointingDown = value;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      return;
    }

    final _ToolbarParentData childParentData = child.parentData;
    context.pushClipPath(
      needsCompositing,
      offset + childParentData.offset,
      Offset.zero & child.size,
      _clipPath(),
      (PaintingContext innerContext, Offset innerOffset) =>
          innerContext.paintChild(child, innerOffset),
    );
  }

  @override
  void performLayout() {
    size = constraints.biggest;

    if (child == null) {
      return;
    }

    child.layout(constraints.copyWith(minHeight: 0.0, minWidth: 0.0),
        parentUsesSize: true);

    final _ToolbarParentData childParentData = child.parentData;
    final double lowerBound = child.size.width / 2 + _kToolbarScreenPadding;
    final double upperBound =
        size.width - child.size.width / 2 - _kToolbarScreenPadding;

    final double _arrowTipX = _boxRect.center.dx.clamp(
        _kToolbarScreenPadding +
            _kToolbarBorderRadius.x +
            _kToolbarArrowSize.width / 2,
        size.width -
            _kToolbarScreenPadding -
            _kToolbarBorderRadius.x -
            _kToolbarArrowSize.width / 2);
    final double _barTopY = _isArrowPointingDown
        ? (_boxRect.top - child.size.height)
        : _boxRect.bottom;

    final double adjustedCenterX = _arrowTipX.clamp(lowerBound, upperBound);

    childParentData.offset =
        Offset(adjustedCenterX - child.size.width / 2, _barTopY);
    childParentData.arrowXOffsetFromCenter = _arrowTipX - adjustedCenterX;
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _ToolbarParentData) {
      child.parentData = _ToolbarParentData();
    }
  }

  Path _clipPath() {
    final _ToolbarParentData childParentData = child.parentData;
    final Path rrect = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset(
                0,
                _isArrowPointingDown ? 0 : _kToolbarArrowSize.height,
              ) &
              Size(child.size.width,
                  child.size.height - _kToolbarArrowSize.height),
          _kToolbarBorderRadius,
        ),
      );

    final double arrowTipX =
        child.size.width / 2 + childParentData.arrowXOffsetFromCenter;

    final double arrowBottomY = _isArrowPointingDown
        ? child.size.height - _kToolbarArrowSize.height
        : _kToolbarArrowSize.height;

    final double arrowTipY = _isArrowPointingDown ? child.size.height : 0;

    final Path arrow = Path()
      ..moveTo(arrowTipX, arrowTipY)
      ..lineTo(arrowTipX - _kToolbarArrowSize.width / 2, arrowBottomY)
      ..lineTo(arrowTipX + _kToolbarArrowSize.width / 2, arrowBottomY)
      ..close();

    return Path.combine(PathOperation.union, rrect, arrow);
  }
}
