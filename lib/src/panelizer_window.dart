import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart' show IconButton, Icons;
import 'package:flutter/widgets.dart';
import 'package:panelizer/src/bottom_panel_container.dart';
import 'package:panelizer/src/divider.dart';
import 'package:panelizer/src/layout.dart';
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

  Layout _layout = Layout.wide;

  final _contentKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newLayout =
        MediaQuery.sizeOf(context).width > 800 ? Layout.wide : Layout.narrow;

    if (newLayout != _layout) {
      _layout = newLayout;
      switch (newLayout) {
        case Layout.wide:
          _showLeft = true;
          _showRight = true;
          _showBottom = true;
        case Layout.narrow:
          _showLeft = false;
          _showRight = false;
          _showBottom = false;
      }
    }
  }

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
      child: Panel(
        backgroundColor: const Color(0xFFFFFFFF),
        child: widget.content,
      ),
    );

    final leftPanel = Panel(
      backgroundColor: const Color(0xFFF4F7FC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: left,
      ),
    );

    final rightPanel = Panel(
      backgroundColor: const Color(0xFFF4F7FC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: right,
      ),
    );

    final bottomPanel = Panel(
      backgroundColor: const Color(0xFFF4F7FC),
      child: BottomPanelContainer(children: widget.bottom),
    );

    final wideLayout = Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_showLeft) Flexible(child: leftPanel),
        if (_showLeft) const Divider.vertical(),
        Flexible(
          flex: 3,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(flex: 2, child: content),
              if (_showBottom) const Divider.horizontal(),
              if (_showBottom) Flexible(child: bottomPanel),
            ],
          ),
        ),
        if (_showRight) const Divider.vertical(),
        if (_showRight) Flexible(child: rightPanel),
      ],
    );

    final narrowLayout = Stack(
      children: [
        content,
        if (_showBottom) bottomPanel,
        if (_showLeft) leftPanel,
        if (_showRight) rightPanel,
      ],
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          Expanded(
            child: switch (_layout) {
              Layout.wide => wideLayout,
              Layout.narrow => narrowLayout,
            },
          ),
          const Divider.horizontal(),
          Container(
            height: 40,
            color: const Color(0xFFF4F7FC),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => setState(() {
                    _showLeft = !_showLeft;
                    if (_layout == Layout.narrow) {
                      _showBottom = false;
                      _showRight = false;
                    }
                  }),
                  icon: Icon(
                    Icons.arrow_circle_left_outlined,
                    color: _showLeft ? null : const Color(0xFFD9DFE7),
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() {
                    _showRight = !_showRight;
                    if (_layout == Layout.narrow) {
                      _showBottom = false;
                      _showLeft = false;
                    }
                  }),
                  icon: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: _showRight ? null : const Color(0xFFD9DFE7),
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() {
                    _showBottom = !_showBottom;
                    if (_layout == Layout.narrow) {
                      _showLeft = false;
                      _showRight = false;
                    }
                  }),
                  icon: Icon(
                    Icons.arrow_circle_down_outlined,
                    color: _showBottom ? null : const Color(0xFFD9DFE7),
                  ),
                ),
                const Divider.vertical(),
                Expanded(child: widget.bottomBar ?? const SizedBox.shrink()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
