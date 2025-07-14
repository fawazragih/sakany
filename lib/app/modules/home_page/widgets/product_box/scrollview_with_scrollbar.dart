import 'package:flutter/material.dart';

class ScrollViewWithScrollBar extends StatelessWidget {
  final Widget child;
  const ScrollViewWithScrollBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thumbColor: Theme.of(context).primaryColor,
      radius: const Radius.circular(20),
      thickness: 3.0,
      // isAlwaysShown: true,
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}
