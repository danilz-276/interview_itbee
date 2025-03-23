part of 'search_task_cubit.dart';

sealed class SearchTaskState {}

final class SearchTaskInitial extends SearchTaskState {}

final class SearchTaskDone extends SearchTaskState {}
