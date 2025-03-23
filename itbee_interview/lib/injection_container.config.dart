// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'presentation/pages/main/cubit/main_cubit.dart' as _i349;
import 'presentation/pages/theme/theme_cubit.dart' as _i270;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt injection_container({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i270.ThemeCubit>(() => _i270.ThemeCubit());
    gh.lazySingleton<_i349.MainCubit>(() => _i349.MainCubit());
    return this;
  }
}
