import 'package:flutter/widgets.dart';

@immutable
class PanelizerTile {
  const PanelizerTile({required this.title, required this.child});

  final String title;
  final Widget child;
}
