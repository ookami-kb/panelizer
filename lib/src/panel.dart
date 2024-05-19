import 'package:flutter/widgets.dart';

class Panel extends StatelessWidget {
  const Panel({
    super.key,
    required this.backgroundColor,
    required this.child,
  });

  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        color: backgroundColor,
        child: child,
      );
}
