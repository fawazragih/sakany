import 'dart:ui';
import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  final Widget child;
  final double start;
  final double end;

  const GlassMorphism({
    super.key,
    required this.child,
    required this.start,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(start),
                Colors.white.withOpacity(end),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class GlassTestWidget extends StatelessWidget {
  const GlassTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
        start: 0.9,
        end: 0.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Observações do pedido',
                    border: InputBorder.none),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 5,
              ),
            ),
          ],
        ));
  }
}
