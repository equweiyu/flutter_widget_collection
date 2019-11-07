import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// copy by [PopupMenuButton]
///
/// Displays a menu when pressed and calls [onSelected] when the menu is dismissed
/// because an item was selected. The value passed to [onSelected] is the value of
/// the selected menu item.
///
/// One of [child] or [icon] may be provided, but not both. If [icon] is provided,
/// then [PopupMenuButtonEx] behaves like an [IconButton].
///
/// If both are null, then a standard overflow icon is created (depending on the
/// platform).
///
/// {@tool sample}
///
/// This example shows a menu with four items, selecting between an enum's
/// values and setting a `_selection` field based on the selection.
///
/// ```dart
/// // This is the type used by the popup menu below.
/// enum WhyFarther { harder, smarter, selfStarter, tradingCharter }
///
/// // This menu button widget updates a _selection field (of type WhyFarther,
/// // not shown here).
/// PopupMenuButton<WhyFarther>(
///   onSelected: (WhyFarther result) { setState(() { _selection = result; }); },
///   itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
///     const PopupMenuItem<WhyFarther>(
///       value: WhyFarther.harder,
///       child: Text('Working a lot harder'),
///     ),
///     const PopupMenuItem<WhyFarther>(
///       value: WhyFarther.smarter,
///       child: Text('Being a lot smarter'),
///     ),
///     const PopupMenuItem<WhyFarther>(
///       value: WhyFarther.selfStarter,
///       child: Text('Being a self-starter'),
///     ),
///     const PopupMenuItem<WhyFarther>(
///       value: WhyFarther.tradingCharter,
///       child: Text('Placed in charge of trading charter'),
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [PopupMenuItem], a popup menu entry for a single value.
///  * [PopupMenuDivider], a popup menu entry that is just a horizontal line.
///  * [CheckedPopupMenuItem], a popup menu item with a checkmark.
///  * [showMenu], a method to dynamically show a popup menu at a given location.
class PopupMenuButtonEx<T> extends StatefulWidget {
  /// Creates a button that shows a popup menu.
  ///
  /// The [itemBuilder] argument must not be null.
  const PopupMenuButtonEx({
    Key key,
    @required this.itemBuilder,
    this.initialValue,
    this.onSelected,
    this.onCanceled,
    this.tooltip,
    this.elevation,
    this.padding = const EdgeInsets.all(8.0),
    this.child,
    this.icon,
    this.offset = Offset.zero,
    this.enabled = true,
    this.shape,
    this.color,
  })  : assert(itemBuilder != null),
        assert(offset != null),
        assert(enabled != null),
        assert(!(child != null &&
            icon != null)), // fails if passed both parameters
        super(key: key);

  /// Called when the button is pressed to create the items to show in the menu.
  final PopupMenuItemBuilder<T> itemBuilder;

  /// The value of the menu item, if any, that should be highlighted when the menu opens.
  final T initialValue;

  /// Called when the user selects a value from the popup menu created by this button.
  ///
  /// If the popup menu is dismissed without selecting a value, [onCanceled] is
  /// called instead.
  final PopupMenuItemSelected<T> onSelected;

  /// Called when the user dismisses the popup menu without selecting an item.
  ///
  /// If the user selects a value, [onSelected] is called instead.
  final PopupMenuCanceled onCanceled;

  /// Text that describes the action that will occur when the button is pressed.
  ///
  /// This text is displayed when the user long-presses on the button and is
  /// used for accessibility.
  final String tooltip;

  /// The z-coordinate at which to place the menu when open. This controls the
  /// size of the shadow below the menu.
  ///
  /// Defaults to 8, the appropriate elevation for popup menus.
  final double elevation;

  /// Matches IconButton's 8 dps padding by default. In some cases, notably where
  /// this button appears as the trailing element of a list item, it's useful to be able
  /// to set the padding to zero.
  final EdgeInsetsGeometry padding;

  /// If provided, the widget used for this button.
  final Widget child;

  /// If provided, the icon used for this button.
  final Icon icon;

  /// The offset applied to the Popup Menu Button.
  ///
  /// When not set, the Popup Menu Button will be positioned directly next to
  /// the button that was used to create it.
  final Offset offset;

  /// Whether this popup menu button is interactive.
  ///
  /// Must be non-null, defaults to `true`
  ///
  /// If `true` the button will respond to presses by displaying the menu.
  ///
  /// If `false`, the button is styled with the disabled color from the
  /// current [Theme] and will not respond to presses or show the popup
  /// menu and [onSelected], [onCanceled] and [itemBuilder] will not be called.
  ///
  /// This can be useful in situations where the app needs to show the button,
  /// but doesn't currently have anything to show in the menu.
  final bool enabled;

  /// If provided, the shape used for the menu.
  ///
  /// If this property is null, then [PopupMenuThemeData.shape] is used.
  /// If [PopupMenuThemeData.shape] is also null, then the default shape for
  /// [MaterialType.card] is used. This default shape is a rectangle with
  /// rounded edges of BorderRadius.circular(2.0).
  final ShapeBorder shape;

  /// If provided, the background color used for the menu.
  ///
  /// If this property is null, then [PopupMenuThemeData.color] is used.
  /// If [PopupMenuThemeData.color] is also null, then
  /// Theme.of(context).cardColor is used.
  final Color color;

  @override
  _PopupMenuButtonState<T> createState() => _PopupMenuButtonState<T>();
}

class _PopupMenuButtonState<T> extends State<PopupMenuButtonEx<T>> {
  void showButtonMenu() {
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    final RenderBox button = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        //Change: start
        button.localToGlobal(button.size.bottomLeft(Offset.zero),
            ancestor: overlay),
        //Change: end
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final List<PopupMenuEntry<T>> items = widget.itemBuilder(context);
    // Only show the menu if there is something to show
    if (items.isNotEmpty) {
      showMenu<T>(
        context: context,
        elevation: widget.elevation ?? popupMenuTheme.elevation,
        items: items,
        initialValue: widget.initialValue,
        position: position,
        shape: widget.shape ?? popupMenuTheme.shape,
        color: widget.color ?? popupMenuTheme.color,
      ).then<void>((T newValue) {
        if (!mounted) return null;
        if (newValue == null) {
          if (widget.onCanceled != null) widget.onCanceled();
          return null;
        }
        if (widget.onSelected != null) widget.onSelected(newValue);
      });
    }
  }

  Icon _getIcon(TargetPlatform platform) {
    assert(platform != null);
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return const Icon(Icons.more_vert);
      case TargetPlatform.iOS:
        return const Icon(Icons.more_horiz);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return widget.child != null
        ? InkWell(
            onTap: widget.enabled ? showButtonMenu : null,
            child: widget.child,
          )
        : IconButton(
            icon: widget.icon ?? _getIcon(Theme.of(context).platform),
            padding: widget.padding,
            tooltip: widget.tooltip ??
                MaterialLocalizations.of(context).showMenuTooltip,
            onPressed: widget.enabled ? showButtonMenu : null,
          );
  }
}
