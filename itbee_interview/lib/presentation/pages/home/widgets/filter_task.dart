import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itbee_interview/localization/strings.dart';
import 'package:itbee_interview/presentation/widgets/check_box_widget.dart';
import 'package:itbee_interview/utils/app_enum.dart';

class FilterTask extends StatefulWidget {
  const FilterTask({super.key, required this.callback, this.data});
  final Function(TaskStatus?) callback;
  final TaskStatus? data;

  @override
  State<FilterTask> createState() => _FilterTaskState();
}

class _FilterTaskState extends State<FilterTask> {
  TaskStatus? status;

  @override
  void initState() {
    super.initState();
    status = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckBoxItem(
            onTap: () {
              if (status == TaskStatus.TODO) return;
              setState(() {
                status = TaskStatus.TODO;
              });
              widget.callback.call(status);
            },
            content: TaskStatus.TODO.title,
            checkboxValue: status == TaskStatus.TODO,
          ),

          CheckBoxItem(
            onTap: () {
              if (status == TaskStatus.DONE) return;
              setState(() {
                status = TaskStatus.DONE;
              });
              widget.callback.call(status);
            },
            content: TaskStatus.DONE.title,
            checkboxValue: status == TaskStatus.DONE,
          ),

          CheckBoxItem(
            onTap: () {
              if (status == null) return;
              setState(() {
                status = null;
              });
              widget.callback.call(status);
            },
            content: Strings.all,
            checkboxValue: status == null,
          ),
        ],
      ),
    );
  }
}
