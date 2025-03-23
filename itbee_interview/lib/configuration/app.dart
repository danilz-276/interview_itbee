import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itbee_interview/presentation/pages/main/main_page.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../utils/const.dart';
import '../utils/custom_navigator_observer.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final CustomNavigatorObserver customNavigatorObserver =
    CustomNavigatorObserver();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late ThemeCubit _themeCubit;
  @override
  void initState() {
    super.initState();
    _themeCubit = GetIt.I<ThemeCubit>();
    _themeCubit.loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _themeCubit,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: Size(Const.SCREEN_WITH, Const.SCREEN_HEIGHT),
            builder: (context, child) {
              return RefreshConfiguration(
                headerBuilder: () => const WaterDropMaterialHeader(),
                footerBuilder:
                    () => CustomFooter(
                      loadStyle: LoadStyle.ShowAlways,
                      builder: (context, mode) {
                        if (mode == LoadStatus.loading) {
                          return SizedBox(
                            height: 60,
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CupertinoActivityIndicator(),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                child: MaterialApp(
                  restorationScopeId: 'app',
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  debugShowCheckedModeBanner: false,
                  title: "",
                  navigatorObservers: [routeObserver, customNavigatorObserver],
                  builder: FToastBuilder(),
                  home: child,
                  theme: ThemeData(
                    primaryColor: _themeCubit.appColors.primaryColor,
                    scaffoldBackgroundColor:
                        _themeCubit.appColors.backgroundColor,
                    dialogTheme: DialogTheme(
                      backgroundColor: _themeCubit.appColors.backgroundColor,
                      surfaceTintColor: Colors.transparent,
                    ),
                    textTheme: GoogleFonts.lexendDecaTextTheme(
                      Theme.of(context).textTheme,
                    ),
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: _themeCubit.appColors.textPrimary,
                      selectionColor: _themeCubit.appColors.textPrimary,
                      selectionHandleColor: _themeCubit.appColors.textPrimary,
                    ),
                  ),
                ),
              );
            },
            child: MainPage(),
          );
        },
      ),
    );
  }
}
