import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:itbee_interview/model/base/task.dart';
import 'package:itbee_interview/services/database/task_dao.dart';
import 'package:itbee_interview/utils/app_enum.dart';
import 'package:itbee_interview/utils/const.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final TaskDao _taskDao = TaskDao();

  HomeCubit() : super(HomeInitial());
  List<Task> listTaskAll = [];
  List<Task> listTaskInProgress = [];
  int pageNumber = Const.PAGE_NUMBER;
  int pageSize = Const.PAGE_SIZE;
  bool canLoadMore = false;
  TaskStatus? statusTemp;
  int totalCount = 0;
  Future<void> getAllTasks({
    bool isRefresh = false,
    bool isLoadMore = false,
    TaskStatus? status,
  }) async {
    emit(isRefresh ? HomeLoading() : HomeInitial());
    canLoadMore = true;
    statusTemp = status ?? statusTemp;
    if (isLoadMore) {
      pageNumber++;
    } else {
      pageNumber = Const.PAGE_NUMBER;
      if (!isRefresh) {
        listTaskAll.clear();
      }
    }

    await _taskDao
        .getTasksWithPaging(
          status: statusTemp?.index,
          page: pageNumber,
          limit: pageSize,
        )
        .then((data) {
          var newData = data["tasks"] as List<Task>;
          totalCount = data["totalCount"] as int;
          if (newData.isEmpty) {
            canLoadMore = false;
          }
          if (isRefresh) {
            listTaskAll = newData;
          }
          if (isLoadMore) {
            listTaskAll.addAll(newData);
          }
          emit(HomeGetDataDone());
        })
        .onError((_, a) {
          emit(HomeGetDataDone());
        });
  }

  Future<void> getSpecialTasks() async {
    listTaskInProgress = await _taskDao.getTasksByStatus(
      TaskStatus.DOING.index,
    );
    emit(HomeGetDataSpecialDone());
  }

  saveStatusTemp(TaskStatus? status) {
    statusTemp = status;
  }

  double percentDoneToday = 0.0;

  /// Lọc task done trong ngày hôm nay
  int _countDoneToday() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return listTaskAll.where((task) {
      final doneDate =
          task.startDate != null
              ? DateFormat('yyyy-MM-dd').format(DateTime.parse(task.startDate!))
              : '';
      return task.status == TaskStatus.DONE.index && doneDate == today;
    }).length;
  }

  /// Lọc tổng task todo + doing trong ngày hôm nay
  int _countTotalToday() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return listTaskAll.where((task) {
      final taskDate =
          task.startDate != null
              ? DateFormat('yyyy-MM-dd').format(DateTime.parse(task.startDate!))
              : '';
      return taskDate == today;
    }).length;
  }

  /// Tính phần trăm task đã hoàn thành trong ngày hôm nay
  void calculateDonePercentage() {
    int doneCount = _countDoneToday();
    int totalCount = _countTotalToday();

    if (totalCount > 0) {
      percentDoneToday = (doneCount / totalCount);
    } else {
      percentDoneToday = 0.0;
    }

    emit(HomeGetPercent()); // Cập nhật UI
  }
}
