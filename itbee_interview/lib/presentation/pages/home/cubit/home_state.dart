part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeSaveStatusTemp extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeGetDataDone extends HomeState {}

final class HomeGetPercent extends HomeState {}

final class HomeGetDataSpecialDone extends HomeState {}
