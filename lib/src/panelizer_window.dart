import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:panelizer/src/bottom_panel_container.dart';
import 'package:panelizer/src/panel.dart';
import 'package:panelizer/src/panelizer_tile.dart';
import 'package:panelizer/src/tile_container.dart';

class PanelizerWindow extends StatelessWidget {
  const PanelizerWindow({
    super.key,
    this.left = const [],
    this.right = const [],
    this.bottom = const [],
    required this.content,
  });

  final List<PanelizerTile> left;
  final List<PanelizerTile> right;
  final List<PanelizerTile> bottom;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final left = this
        .left
        .map<Widget>((tile) => TileContainer(tile: tile))
        .intersperse(Container(height: 1, color: const Color(0xFFE7EBF1)))
        .toList();

    final right = this
        .right
        .map<Widget>((tile) => TileContainer(tile: tile))
        .intersperse(Container(height: 1, color: const Color(0xFFE7EBF1)))
        .toList();

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Panel(
              backgroundColor: const Color(0xFFF4F7FC),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: left,
              ),
            ),
          ),
          Container(
            width: 1,
            color: const Color(0xFFD9DFE7),
          ),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 2,
                  child: Panel(
                    backgroundColor: Colors.white,
                    child: content,
                  ),
                ),
                Container(
                  height: 1,
                  color: const Color(0xFFD9DFE7),
                ),
                Flexible(
                  child: Panel(
                    backgroundColor: const Color(0xFFF4F7FC),
                    child: BottomPanelContainer(children: bottom),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            color: const Color(0xFFD9DFE7),
          ),
          Flexible(
            child: Panel(
              backgroundColor: const Color(0xFFF4F7FC),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
