import 'package:flutter/material.dart';

import 'package:yamada/providers/appearance_provider.dart';
import 'fluent_item_card.dart';

class SettingGroupHeader extends StatelessWidget {
  final String text;

  const SettingGroupHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(text, style: Theme.of(context).textTheme.titleSmall),
    );
  }
}

class SettingTile extends StatelessWidget {
  final IconData icon;
  final IconData? fluentIcon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingTile({
    super.key,
    required this.icon,
    this.fluentIcon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isFluent = DesignScope.of(context) == AppDesign.fluent;
    if (isFluent) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        child: FluentItemCard(
          leading: Icon(fluentIcon ?? icon),
          label: Text(title),
          trailing: trailing,
        ),
      );
    }
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
