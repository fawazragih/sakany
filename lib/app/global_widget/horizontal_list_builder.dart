import 'package:flutter/cupertino.dart';

class HorizontalListBuilder<T> extends StatelessWidget {
  final List<T>? items;
  final int? itemCount;
  final Widget Function(T item) widget;

  const HorizontalListBuilder({
    super.key,
    required this.items,
    required this.itemCount,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // dragStartBehavior: DragStartBehavior.down,
      scrollDirection: Axis.horizontal,
      child: Row(
        // mainAxisSize: MainAxisSize.min,
          children: items
                  ?.map(
                    (T e) => widget.call(e),
                  )
                  .toList() ??
              []),
    );
  }
}
