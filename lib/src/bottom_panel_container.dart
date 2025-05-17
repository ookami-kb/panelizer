import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:panelizer/src/panelizer_tile.dart';

class BottomPanelContainer extends StatefulWidget {
  const BottomPanelContainer({super.key, required this.children});

  final List<PanelizerTile> children;

  @override
  State<BottomPanelContainer> createState() => _BottomPanelContainerState();
}

class _BottomPanelContainerState extends State<BottomPanelContainer> {
  int _activeItem = 0;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      SizedBox(
        height: 30,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children:
              widget.children
                  .mapIndexed(
                    (i, e) => GestureDetector(
                      onTap: () => setState(() => _activeItem = i),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          e.title.toUpperCase(),
                          style: TextStyle(
                            fontWeight: i == _activeItem ? FontWeight.bold : FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ),
      Expanded(child: widget.children[_activeItem].child),
    ],
  );
}
