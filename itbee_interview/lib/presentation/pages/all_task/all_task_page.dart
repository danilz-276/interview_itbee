import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itbee_interview/configuration/gen/assets.gen.dart';

class AllTaskPage extends StatelessWidget {
  const AllTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(MyAssets.pngs.empty.path, height: 120.h, width: 120.w),
    );
  }
}
