import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:itbee_interview/configuration/app_styles.dart';
import 'package:itbee_interview/model/base/task.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';
import 'package:itbee_interview/presentation/widgets/singletap_detector.dart';
import 'package:itbee_interview/utils/app_enum.dart';

class CardDetailTask extends StatelessWidget {
  const CardDetailTask({
    super.key,
    required this.themeCurrent,
    this.isLast = false,
    required this.data,
    required this.press,
  });

  final ThemeCubit themeCurrent;
  final bool isLast;
  final Task data;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SingleTapDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        margin: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 6.h,
          bottom: isLast ? 32.h : 6.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: themeCurrent.appColors.backgroundColor,
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: themeCurrent.appColors.textPrimary.withOpacity(.3),
              offset: Offset(0, 1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.text15w500.copyWith(
                          color: themeCurrent.appColors.textPrimary,
                        ),
                      ),
                      Text(
                        data.description ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.text12w400.copyWith(
                          // ignore: deprecated_member_use
                          color: themeCurrent.appColors.textPrimary.withOpacity(
                            .8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                8.horizontalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    // ignore: deprecated_member_use
                    color: themeCurrent.appColors.primaryColor.withOpacity(.3),
                  ),
                  child: Text(
                    data.status == TaskStatus.DONE.index
                        ? TaskStatus.DONE.title
                        : data.status == TaskStatus.DOING.index
                        ? TaskStatus.DOING.title
                        : TaskStatus.TODO.title,

                    style: Theme.of(context).textTheme.text10w400.copyWith(
                      color: themeCurrent.appColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            4.verticalSpace,
            Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Row(
                //   children: [
                //     Icon(
                //       Icons.alarm,
                //       size: 12.w,
                //       color: themeCurrent.appColors.primaryColor,
                //     ),

                //     4.horizontalSpace,
                //     Text(
                //       time,
                //       maxLines: 1,
                //       overflow: TextOverflow.ellipsis,
                //       style: Theme.of(context).textTheme.text10w400.copyWith(
                //         color: themeCurrent.appColors.primaryColor,
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 12.w,
                      color: themeCurrent.appColors.primaryColor,
                    ),
                    4.horizontalSpace,
                    Text(
                      DateFormat('dd/MM/yyyy').format(
                        DateTime.parse(
                          data.startDate ?? DateTime.now().toString(),
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.text10w400.copyWith(
                        color: themeCurrent.appColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  '    -    ',
                  style: Theme.of(context).textTheme.text10w400.copyWith(
                    color: themeCurrent.appColors.primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 12.w,
                      color: themeCurrent.appColors.primaryColor,
                    ),
                    4.horizontalSpace,
                    Text(
                      DateFormat('dd/MM/yyyy').format(
                        DateTime.parse(
                          data.dueDate ?? DateTime.now().toString(),
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.text10w400.copyWith(
                        color: themeCurrent.appColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
