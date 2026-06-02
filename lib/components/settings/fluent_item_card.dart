import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

/// The [FluentItemCard] like [Expander] but can't expand.
/// You can add trailing content to feel like Windows settings.
///
/// Credits: [fluent_ui]: [Expander]
class FluentItemCard extends StatelessWidget {
  const FluentItemCard({
    super.key,
    this.leading,
    required this.label,
    this.trailing,
    this.contentBackgroundColor,
    this.contentPadding = const EdgeInsets.all(16.0),
  });

  /// The leading widget.
  ///
  /// See also:
  ///
  ///  * [Icon], used to display graphic content
  ///  * [RadioButton], used to select an exclusive option from a set of options
  ///  * [Checkbox], used to select or deselect items within a list
  final Widget? leading;

  /// The setting card content
  final Widget label;

  /// The trailing widget. It's positioned at the right of [content].
  ///
  /// See also:
  ///
  ///  * [ToggleSwitch], used to toggle a setting between two states
  final Widget? trailing;

  /// The background color of the content.
  final WidgetStateProperty<Color>? contentBackgroundColor;

  /// The padding of the content.
  final EdgeInsetsGeometry? contentPadding;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty(
          'contentBackgroundColor', contentBackgroundColor as Color?))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>(
        'contentPadding',
        contentPadding,
        defaultValue: const EdgeInsets.all(16.0),
      ));
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final theme = FluentTheme.of(context);
    final children = [
      // Content
      HoverButton(
        hitTestBehavior: HitTestBehavior.deferToChild,
        builder: (context, states) {
          return Container(
            constraints: const BoxConstraints(
              minHeight: 42.0,
            ),
            decoration: ShapeDecoration(
              color: contentBackgroundColor?.resolve(states) ??
                  theme.resources.cardBackgroundFillColorDefault,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: theme.resources.cardStrokeColorDefault,
                ),
                borderRadius: BorderRadius.vertical(
                  top: const Radius.circular(6.0),
                  bottom: Radius.circular(6.0),
                ),
              ),
            ),
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            alignment: AlignmentDirectional.centerStart,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              if (leading != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10.0),
                  child: leading!,
                ),
              Expanded(child: label),
              if (trailing != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20.0),
                  child: trailing!,
                ),
            ]),
          );
        },
      ),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children.reversed.toList(),
    );
  }
}
