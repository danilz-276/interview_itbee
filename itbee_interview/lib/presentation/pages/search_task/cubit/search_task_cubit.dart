import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itbee_interview/model/base/task.dart';
import 'package:itbee_interview/services/database/task_dao.dart';

part 'search_task_state.dart';

class SearchTaskCubit extends Cubit<SearchTaskState> {
  SearchTaskCubit() : super(SearchTaskInitial());
  final TaskDao _taskDao = TaskDao();

  List<Task> listTask = [];
  Timer? _debounce;
  Future<void> searchTasks(String query) async {
    if (query.isEmpty) {
      listTask.clear();
      emit(SearchTaskDone());
      return;
    }
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(SearchTaskInitial());

      listTask = await _taskDao.searchTasks(query);
      emit(SearchTaskDone());
    });
  }
}
