import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itbee_interview/configuration/app_styles.dart';
import 'package:itbee_interview/utils/app_enum.dart';

class Utils {
  static void onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  static void showToast(
    BuildContext context,
    String? title, {
    ToastType type = ToastType.ERROR,
    String? subTitle,
    bool isPrefixIcon = true,
    bool isShowDivider = false,
    bool isShowMessageIcon = true,
  }) {
    onWidgetDidBuild(() {
      FToast fToast = FToast();
      fToast.init(context);
      fToast.removeQueuedCustomToasts();
      Widget toast = Container(
        width: 1.sw,
        margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(type.radius),
          color: type.backgroundColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 10.r,
              spreadRadius: 3,
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isShowMessageIcon) ...[
              Icon(Icons.done_sharp, color: type.titleColor),
              10.horizontalSpace,
            ],
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? "",
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.text16w600
                              .copyWith(color: type.titleColor),
                        ),
                        if (subTitle != null && subTitle.isNotEmpty)
                          Text(
                            subTitle,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.text10w400
                                .copyWith(color: type.subTitleColor),
                          ),
                      ],
                    ),
                  ),
                  if (isShowDivider)
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 2.w,
                      child: Container(
                        width: 5.w,
                        decoration: BoxDecoration(
                          color: type.titleColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (isPrefixIcon == true)
              InkWell(
                onTap: () {
                  fToast.removeCustomToast();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  child: Icon(Icons.delete, color: type.crossColor),
                ),
              ),
          ],
        ),
      );

      if (title != null) {
        fToast.showToast(
          child: toast,
          gravity: ToastGravity.TOP,
          positionedToastBuilder: (context, child, a) {
            return Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              right: 0,
              child: child,
            );
          },
          toastDuration: const Duration(seconds: 3),
        );
      }
    });
  }
}
