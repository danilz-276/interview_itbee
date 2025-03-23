import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itbee_interview/model/base/task.dart';
import 'package:itbee_interview/services/database/task_dao.dart';
import 'package:itbee_interview/utils/app_enum.dart';

part 'detail_task_state.dart';

class DetailTaskCubit extends Cubit<DetailTaskState> {
  final TaskDao _taskDao = TaskDao();
  DetailTaskCubit() : super(DetailTaskInitial());
  TextEditingController projectName = TextEditingController();
  TextEditingController description = TextEditingController();
  DateTime? startDate, endDate;

  addTask() async {
    emit(DetailTaskLoading());
    await _taskDao.insertTask(
      Task(
        title: projectName.text,
        description: description.text,
        startDate: startDate.toString(),
        dueDate: endDate.toString(),
        status: statusTemp.index,
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
      ),
    );
    // NotiService().scheduleNotification(
    //   id: id,
    //   title: projectName.text,
    //   body: description.text,
    //   year: startDate?.year ?? DateTime.now().year,
    //   month: startDate?.month ?? DateTime.now().month,
    //   day: startDate?.day ?? DateTime.now().day,
    //   hour: 17,
    //   minute: 10,
    // );
    emit(DetailTaskSuccess());
  }

  Task? taskDetail;

  getDetail(int id) async {
    emit(DetailTaskLoading());
    activeEdit = false;
    taskDetail = await _taskDao.getTaskById(id);
    if (taskDetail != null) {
      projectName.text = taskDetail?.title ?? '';
      description.text = taskDetail?.description ?? '';
      startDate = DateTime.tryParse(taskDetail?.startDate ?? '');
      endDate = DateTime.tryParse(taskDetail?.dueDate ?? '');
      statusTemp =
          taskDetail?.status == TaskStatus.DONE.index
              ? TaskStatus.DONE
              : taskDetail?.status == TaskStatus.DOING.index
              ? TaskStatus.DOING
              : TaskStatus.TODO;
    }
    emit(DetailTaskInitial());
  }

  changeStartEndDate({DateTime? start, DateTime? end}) {
    emit(DetailTaskChanging());
    startDate = start ?? startDate;
    endDate = end ?? endDate;
    emit(DetailTaskChanged());
  }

  bool activeEdit = true;
  configEditTask({bool active = false}) {
    emit(DetailTaskInitial());

    activeEdit = active;
    emit(DetailTaskEdit());
  }

  deleteTask({required int id}) async {
    emit(DetailTaskLoading());
    await _taskDao.deleteTask(id);
    // NotiService().cancelNoti(id: id);

    emit(DetailTaskDeleted());
  }

  updateTask() async {
    emit(DetailTaskLoading());
    await _taskDao.updateTask(
      Task(
        id: taskDetail?.id,
        title: projectName.text,
        description: description.text,
        status: statusTemp.index,
        startDate: startDate.toString(),
        dueDate: endDate.toString(),
        createdAt: taskDetail?.createdAt ?? DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
      ),
    );
    // NotiService().cancelNoti(id: taskDetail?.id ?? 0);
    // NotiService().scheduleNotification(
    //   id: taskDetail?.id ?? 0,
    //   title: projectName.text,
    //   body: description.text,
    //   year: startDate?.year ?? DateTime.now().year,
    //   month: startDate?.month ?? DateTime.now().month,
    //   day: startDate?.day ?? DateTime.now().day,
    //   hour: 7,
    //   minute: 0,
    // );
    activeEdit = false;
    emit(DetailTaskUpdated());
  }

  TaskStatus statusTemp = TaskStatus.TODO;

  updateTaskStatus(TaskStatus status) async {
    if (status == statusTemp) return;
    if (taskDetail?.id == null) return;
    statusTemp = status;
    if (!activeEdit) {
      await _taskDao.updateTaskStatus(taskDetail!.id!, statusTemp.index);
    }
    emit(DetailTaskLoading());
    emit(DetailTaskInitial());
  }
}
