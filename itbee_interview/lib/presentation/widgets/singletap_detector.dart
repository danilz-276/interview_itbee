import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleTapDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final int delayTimeInMillisecond;

  const SingleTapDetector({
    super.key,
    required this.child,
    this.onTap,
    this.delayTimeInMillisecond = 1000,
  });

  @override
  State<SingleTapDetector> createState() => _SingleTapDetectorState();
}

class _SingleTapDetectorState extends State<SingleTapDetector> {
  int clickTime = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // behavior: HitTestBehavior.translucent,
      child: widget.child,
      onTap: () {
        HapticFeedback.selectionClick();

        var currentTime = DateTime.now().millisecondsSinceEpoch;

        if (currentTime - clickTime > 500) {
          widget.onTap?.call();
          if (mounted) {
            setState(() {
              clickTime = currentTime;
            });
          }
        }
      },
    );
  }
}
