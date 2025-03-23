import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'main_state.dart';

@LazySingleton()
class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  int currentPosition = 0;
  onNavigateMainPage(int position) {
    if (currentPosition == position) return;
    emit(MainInitial());
    currentPosition = position;
    emit(MainNavigation());
  }
}
