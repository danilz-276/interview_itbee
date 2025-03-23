import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:itbee_interview/configuration/app_styles.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';

class CalendarPickerCustom extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final void Function(List<DateTime?>)? onChange;

  final String? titleStart;
  final String? titleEnd;

  final bool pickPrevious;
  final ThemeCubit themeCurrent;

  const CalendarPickerCustom({
    super.key,
    this.startDate,
    this.endDate,
    this.onChange,

    this.titleStart,
    this.titleEnd,
    this.pickPrevious = false,
    required this.themeCurrent,
  });

  @override
  State<CalendarPickerCustom> createState() => _CalendarPickerCustomState();
}

class _CalendarPickerCustomState extends State<CalendarPickerCustom> {
  List<DateTime?> _rangeDatePickerWithActionButtonsWithValue = [];
  late CalendarDatePicker2Config? config;

  @override
  void initState() {
    super.initState();
    _rangeDatePickerWithActionButtonsWithValue.add(widget.startDate);

    _rangeDatePickerWithActionButtonsWithValue.add(widget.endDate);
    config = CalendarDatePicker2Config(
      dayBuilder: ({
        required DateTime date,
        TextStyle? textStyle,
        BoxDecoration? decoration,
        bool? isSelected,
        bool? isDisabled,
        bool? isToday,
      }) {
        Widget? dayWidget;
        if (isDisabled == true) {
          dayWidget = Container(
            decoration: decoration,
            child: Center(child: Text(date.day.toString(), style: textStyle)),
          );
        } else {
          dayWidget = Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0.w),
            child: Container(
              decoration: decoration,
              child: Center(child: Text(date.day.toString(), style: textStyle)),
            ),
          );
        }

        return dayWidget;
      },
      firstDayOfWeek: 0,

      // disableMonthPicker: true,
      // modePickerTextHandler: ({isMonthPicker, required monthDate}) {
      //   return '${monthDate.month} - ${monthDate.year}';
      // },
      selectableDayPredicate:
          widget.pickPrevious
              ? null
              : (day) =>
                  !day
                      .difference(
                        DateTime.now().subtract(const Duration(days: 1)),
                      )
                      .isNegative,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: widget.themeCurrent.appColors.primaryColor,
      weekdayLabelTextStyle: TextStyle(
        color: widget.themeCurrent.appColors.primaryColor,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: TextStyle(
        color: widget.themeCurrent.appColors.textPrimary,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      disabledDayTextStyle: TextStyle(
        color: widget.themeCurrent.appColors.textSecondary,
        fontSize: 12.sp,
      ),
      dayBorderRadius: BorderRadius.circular(12.r),
      dayTextStyle: TextStyle(
        color: widget.themeCurrent.appColors.textPrimary,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        25.verticalSpace,
        Container(
          margin: EdgeInsets.symmetric(horizontal: 21.w),
          padding: EdgeInsets.symmetric(vertical: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            color: widget.themeCurrent.appColors.primaryColor,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.titleStart ?? '',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.text12w400.copyWith(
                        color: widget.themeCurrent.appColors.taskCardBorder,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      _rangeDatePickerWithActionButtonsWithValue.firstOrNull !=
                              null
                          ? DateFormat('dd/MM/yyyy').format(
                            _rangeDatePickerWithActionButtonsWithValue
                                .firstOrNull!,
                          )
                          : 'dd/MM/yyyy',
                      style: Theme.of(context).textTheme.text12w500.copyWith(
                        height: 0,
                        color: widget.themeCurrent.appColors.taskCardBorder,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 24,
                width: 1,
                color: widget.themeCurrent.appColors.textSecondary,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.titleEnd ?? '',
                      style: Theme.of(context).textTheme.text12w400.copyWith(
                        color: widget.themeCurrent.appColors.taskCardBorder,
                        height: 0,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      _rangeDatePickerWithActionButtonsWithValue.length > 1 &&
                              _rangeDatePickerWithActionButtonsWithValue
                                      .lastOrNull !=
                                  null
                          ? DateFormat('dd/MM/yyyy').format(
                            _rangeDatePickerWithActionButtonsWithValue
                                .lastOrNull!,
                          )
                          : 'dd/MM/yyyy',
                      style: Theme.of(context).textTheme.text12w600.copyWith(
                        height: 0,
                        color: widget.themeCurrent.appColors.taskCardBorder,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (config != null)
          CalendarDatePicker2(
            config: config!,
            value: _rangeDatePickerWithActionButtonsWithValue,
            onValueChanged: (value) {
              if (value.length > 1 &&
                  value.lastOrNull != null &&
                  value.firstOrNull != null &&
                  value.lastOrNull!.isAfter(value.firstOrNull!)) {
                if (mounted) {
                  setState(() {
                    _rangeDatePickerWithActionButtonsWithValue = value;
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _rangeDatePickerWithActionButtonsWithValue = [
                      value.firstOrNull,
                    ];
                  });
                }
              }

              widget.onChange?.call(_rangeDatePickerWithActionButtonsWithValue);
            },
            onDisplayedMonthChanged: (DateTime newMonth) {},
          ),
      ],
    );
  }
}
