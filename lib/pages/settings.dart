import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  static const pageTitle = Text('Settings');

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) return buildFluent(context);
    return buildMaterial(context);
  }

  Widget buildMaterial(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: pageTitle),
      body: homeContent(context),
    );
  }

  Widget buildFluent(BuildContext context) {
    return fluent.ScaffoldPage(
      header: const fluent.PageHeader(title: pageTitle),
      content: homeContent(context),
    );
  }

  Widget homeContent(BuildContext context) {
    return Center(
      child: const Text('Settings', style: TextStyle(fontSize: 16)),
    );
  }
}
