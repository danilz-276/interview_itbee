part of 'detail_task_cubit.dart';

sealed class DetailTaskState {}

final class DetailTaskInitial extends DetailTaskState {}

final class DetailTaskLoading extends DetailTaskState {}

final class DetailTaskSuccess extends DetailTaskState {}

final class DetailTaskDeleted extends DetailTaskState {}

final class DetailTaskUpdated extends DetailTaskState {}

final class DetailTaskChanging extends DetailTaskState {}

final class DetailTaskChanged extends DetailTaskState {}

final class DetailTaskEdit extends DetailTaskState {}

