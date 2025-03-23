import 'package:flutter_bloc/flutter_bloc.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  bool isDark = false;
  bool isNoti = false;

  changeDark(bool data) {
    emit(SettingInitial());
    isDark = data;
    emit(SettingMode());
  }

  changeNoti() {
    emit(SettingInitial());
    isNoti = !isNoti;
    emit(SettingNoti());
  }
}
