import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:panelizer/src/bottom_panel_container.dart';
import 'package:panelizer/src/panel.dart';
import 'package:panelizer/src/panelizer_tile.dart';
import 'package:panelizer/src/tile_container.dart';

class PanelizerWindow extends StatefulWidget {
  const PanelizerWindow({
    super.key,
    this.left = const [],
    this.right = const [],
    this.bottom = const [],
    this.bottomBar,
    required this.content,
  });

  final List<PanelizerTile> left;
  final List<PanelizerTile> right;
  final List<PanelizerTile> bottom;
  final Widget content;
  final Widget? bottomBar;

  @override
  State<PanelizerWindow> createState() => _PanelizerWindowState();
}

class _PanelizerWindowState extends State<PanelizerWindow> {
  bool _showLeft = true;
  bool _showRight = true;
  bool _showBottom = true;

  final _contentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final left = widget.left
        .map<Widget>((tile) => TileContainer(tile: tile))
        .intersperse(Container(height: 1, color: const Color(0xFFE7EBF1)))
        .toList();

    final right = widget.right
        .map<Widget>((tile) => TileContainer(tile: tile))
        .intersperse(Container(height: 1, color: const Color(0xFFE7EBF1)))
        .toList();

    final content = KeyedSubtree(
      key: _contentKey,
      child: widget.content,
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_showLeft)
                  Flexible(
                    child: Panel(
                      backgroundColor: const Color(0xFFF4F7FC),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: left,
                      ),
                    ),
                  ),
                if (_showLeft)
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
                      if (_showBottom)
                        Container(
                          height: 1,
                          color: const Color(0xFFD9DFE7),
                        ),
                      if (_showBottom)
                        Flexible(
                          child: Panel(
                            backgroundColor: const Color(0xFFF4F7FC),
                            child:
                                BottomPanelContainer(children: widget.bottom),
                          ),
                        ),
                    ],
                  ),
                ),
                if (_showRight)
                  Container(
                    width: 1,
                    color: const Color(0xFFD9DFE7),
                  ),
                if (_showRight)
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
          ),
          Container(
            height: 1,
            color: const Color(0xFFD9DFE7),
          ),
          Container(
            height: 40,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => setState(() => _showLeft = !_showLeft),
                  icon: const Icon(Icons.arrow_circle_left_outlined),
                ),
                IconButton(
                  onPressed: () => setState(() => _showRight = !_showRight),
                  icon: const Icon(Icons.arrow_circle_right_outlined),
                ),
                IconButton(
                  onPressed: () => setState(() => _showBottom = !_showBottom),
                  icon: const Icon(Icons.arrow_circle_down_outlined),
                ),
                Container(
                  width: 1,
                  color: const Color(0xFFD9DFE7),
                ),
                Expanded(child: widget.bottomBar ?? const SizedBox.shrink()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
