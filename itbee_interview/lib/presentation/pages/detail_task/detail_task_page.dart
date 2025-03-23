import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:itbee_interview/injection_container.dart';
import 'package:itbee_interview/localization/strings.dart';
import 'package:itbee_interview/presentation/pages/detail_task/cubit/detail_task_cubit.dart';
import 'package:itbee_interview/presentation/pages/detail_task/widgets/app_bar_custom.dart';
import 'package:itbee_interview/presentation/pages/detail_task/widgets/bottom_app_custom.dart';
import 'package:itbee_interview/presentation/pages/detail_task/widgets/calendar_custom.dart';
import 'package:itbee_interview/presentation/pages/detail_task/widgets/day_picker_field_custom.dart';
import 'package:itbee_interview/presentation/pages/detail_task/widgets/textfield_custom.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';
import 'package:itbee_interview/presentation/widgets/button_widget.dart';
import 'package:itbee_interview/presentation/widgets/check_box_widget.dart';
import 'package:itbee_interview/utils/app_enum.dart';
import 'package:itbee_interview/utils/navigation.dart';
import 'package:itbee_interview/utils/utils.dart';

class DetailTaskPage extends StatefulWidget {
  const DetailTaskPage({super.key, this.id});

  final int? id;

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  final themeCurrent = getIt<ThemeCubit>();
  late DetailTaskCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = DetailTaskCubit();
    getData();
  }

  getData() {
    if (widget.id != null) {
      _cubit.getDetail(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<DetailTaskCubit, DetailTaskState>(
        listener: (context, state) {
          if (state is DetailTaskSuccess) {
            Utils.showToast(
              context,
              'Thêm thành công',
              type: ToastType.SUCCESS,
            );
            NavigationUtils.popPage(context);
          }
          if (state is DetailTaskDeleted) {
            Utils.showToast(context, 'Xóa thành công');
            NavigationUtils.popPage(context);
          }
          if (state is DetailTaskUpdated) {
            Utils.showToast(
              context,
              'Cập nhập thành công',
              type: ToastType.SUCCESS,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: BottomAppCustom(
              listWidget: [
                if (widget.id == null) ...[
                  Expanded(
                    child: ButtonWidget(
                      press: () {
                        _cubit.addTask();
                      },
                      activeTitle: Strings.createNew,
                      activeTextColor: themeCurrent.appColors.taskCardBorder,
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: ButtonWidget(
                      press: () {
                        dialog(
                          context: context,
                          title: Strings.delete,
                          desc: Strings.confirmDeleteTask,
                          pressAgree: () {
                            NavigationUtils.popDialog(context);
                            _cubit.deleteTask(id: widget.id!);
                          },
                        );
                      },
                      activeTitle: Strings.delete,
                      activeTextColor: themeCurrent.appColors.taskCardBorder,
                    ),
                  ),
                  if (_cubit.activeEdit) ...[
                    12.horizontalSpace,
                    Expanded(
                      child: ButtonWidget(
                        press: () {
                          dialog(
                            context: context,
                            title: Strings.update,
                            desc: Strings.confirmUpdateTask,
                            pressAgree: () {
                              NavigationUtils.popDialog(context);
                              _cubit.updateTask();
                            },
                          );
                        },
                        activeTitle: Strings.update,
                        activeTextColor: themeCurrent.appColors.taskCardBorder,
                      ),
                    ),
                  ],
                ],
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  AppBarCustom(
                    themeCurrent: themeCurrent,
                    activeEdit:
                        widget.id != null &&
                        _cubit.taskDetail != null &&
                        !_cubit.activeEdit,
                    press: () {
                      _cubit.configEditTask(active: true);
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            24.verticalSpace,
                            TextFieldCustom(
                              themeCurrent: themeCurrent,
                              label: Strings.taskName,
                              controller: _cubit.projectName,
                              isActive: _cubit.activeEdit,
                            ),
                            24.verticalSpace,
                            TextFieldCustom(
                              themeCurrent: themeCurrent,
                              label: Strings.description,
                              maxline: 5,
                              isCenter: false,
                              controller: _cubit.description,
                              isActive: _cubit.activeEdit,
                            ),
                            24.verticalSpace,

                            DayPickerFieldCustom(
                              themeCurrent: themeCurrent,
                              isActive: _cubit.activeEdit,

                              label: Strings.startDate,
                              day:
                                  _cubit.startDate != null
                                      ? DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(_cubit.startDate!)
                                      : 'dd/MM/yyyy',
                              press: () {
                                _showDateTimePicker(context);
                              },
                            ),
                            24.verticalSpace,

                            DayPickerFieldCustom(
                              themeCurrent: themeCurrent,
                              isActive: _cubit.activeEdit,

                              label: Strings.dueDate,
                              day:
                                  _cubit.endDate != null
                                      ? DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(_cubit.endDate!)
                                      : 'dd/MM/yyyy',
                              press: () {
                                _showDateTimePicker(context);
                              },
                            ),
                            24.verticalSpace,
                            Row(
                              children: [
                                Expanded(
                                  child: CheckBoxItem(
                                    checkboxValue:
                                        _cubit.statusTemp == TaskStatus.TODO,
                                    content: TaskStatus.TODO.title,
                                    onTap: () {
                                      _cubit.updateTaskStatus(TaskStatus.TODO);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: CheckBoxItem(
                                    checkboxValue:
                                        _cubit.statusTemp == TaskStatus.DOING,
                                    content: TaskStatus.DOING.title,
                                    onTap: () {
                                      _cubit.updateTaskStatus(TaskStatus.DOING);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: CheckBoxItem(
                                    checkboxValue:
                                        _cubit.statusTemp == TaskStatus.DONE,
                                    content: TaskStatus.DONE.title,
                                    onTap: () {
                                      _cubit.updateTaskStatus(TaskStatus.DONE);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> dialog({
    required BuildContext context,
    required String title,
    required String desc,
    VoidCallback? pressBack,
    required VoidCallback pressAgree,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(desc),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed:
                  pressBack ??
                  () {
                    NavigationUtils.popDialog(context);
                  },
              child:  Text(Strings.back),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: pressAgree,
              child:  Text(Strings.confirm),
            ),
          ],
        );
      },
    );
  }

  _showDateTimePicker(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => Dialog(
            insetPadding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            child: CalendarPickerCustom(
              endDate: _cubit.endDate,
              startDate: _cubit.startDate,
              onChange: (dates) {
                _cubit.changeStartEndDate(
                  start: dates.firstOrNull,
                  end:
                      (dates.lastOrNull != null && dates.length > 1)
                          ? dates.lastOrNull
                          : null,
                );
              },
              themeCurrent: themeCurrent,
              titleStart: Strings.startDate,
              titleEnd: Strings.dueDate,
            ),
          ),
    ).then((value) => {});
  }
}
