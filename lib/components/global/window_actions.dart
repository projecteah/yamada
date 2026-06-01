import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:window_manager/window_manager.dart';

class WindowActions extends StatelessWidget {
  const WindowActions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = fluent.FluentTheme.of(context);

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      SizedBox(
        width: 138,
        height: 40,
        child: WindowCaption(
          brightness: theme.brightness,
          backgroundColor: Colors.transparent,
        ),
      ),
    ]);
  }
}
