import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomAppCustom extends StatelessWidget {
  const BottomAppCustom({super.key, required this.listWidget});

  final List<Widget> listWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 16.h,
            bottom: MediaQuery.of(context).viewPadding.bottom + 12.h,
          ),
          child: Row(children: listWidget),
        ),
      ],
    );
  }
}
