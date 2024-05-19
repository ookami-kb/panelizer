import 'package:flutter/material.dart';
import 'package:panelizer/src/panelizer_tile.dart';

class TileContainer extends StatefulWidget {
  const TileContainer({super.key, required this.tile});

  final PanelizerTile tile;

  @override
  State<TileContainer> createState() => _TileContainerState();
}

class _TileContainerState extends State<TileContainer> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final chevron = _isExpanded
        ? Icons.keyboard_arrow_down_sharp
        : Icons.keyboard_arrow_right_sharp;

    final title = GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(chevron),
                ),
                TextSpan(
                  text: widget.tile.title.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return _isExpanded
        ? Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                if (_isExpanded)
                  Expanded(
                    child: widget.tile.child,
                  ),
              ],
            ),
          )
        : title;
  }
}
