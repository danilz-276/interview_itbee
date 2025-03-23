import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itbee_interview/configuration/app_colors.dart';
import 'package:itbee_interview/services/database/theme_dao.dart';
import 'package:injectable/injectable.dart';
part 'theme_state.dart';

@Singleton()
class ThemeCubit extends Cubit<ThemeState> {
  final ThemeDao _themeDao = ThemeDao();

  bool isDarkMode = false;
  AppColors appColors = AppColors.light;

  ThemeCubit() : super(ThemeInitial());
  Future<void> loadTheme() async {
    bool isDarkMode = await _themeDao.getCurrentTheme();
    this.isDarkMode = isDarkMode;
    appColors = this.isDarkMode ? AppColors.dark : AppColors.light;
    emit(ThemeInitial());
    emit(ThemeLoaded());
  }

  Future<void> toggleTheme() async {
    bool isDarkMode = await _themeDao.getCurrentTheme();

    await _themeDao.setTheme(!isDarkMode);
    this.isDarkMode = !isDarkMode;

    appColors = this.isDarkMode ? AppColors.dark : AppColors.light;
    emit(ThemeInitial());
    emit(ThemeLoaded());
  }
}
