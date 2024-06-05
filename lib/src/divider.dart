import 'package:flutter/material.dart';

class Divider extends StatelessWidget {
  const Divider({
    super.key,
    this.height,
    this.width,
  });

  const Divider.horizontal({Key? key}) : this(key: key, height: 1);

  const Divider.vertical({Key? key}) : this(key: key, width: 1);

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        width: width,
        color: const Color(0xFFD9DFE7),
      );
}
