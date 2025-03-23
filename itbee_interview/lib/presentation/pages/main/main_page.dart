import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:itbee_interview/configuration/gen/assets.gen.dart';
import 'package:itbee_interview/presentation/pages/all_task/all_task_page.dart';
import 'package:itbee_interview/presentation/pages/detail_task/detail_task_page.dart';
import 'package:itbee_interview/presentation/pages/home/cubit/home_cubit.dart';
import 'package:itbee_interview/presentation/pages/home/home_page.dart';
import 'package:itbee_interview/utils/const.dart';
import 'package:itbee_interview/utils/navigation.dart';

import '../theme/theme_cubit.dart';
import 'cubit/main_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  final _controller = PageController();
  late MainCubit _cubit;
  late HomeCubit _homeCubit;

  final _themeCubit = GetIt.I<ThemeCubit>();
  final GlobalKey<NavigatorState> _homeNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _allTaskNavKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    _cubit = GetIt.I<MainCubit>();
    _homeCubit = HomeCubit();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  bool get wantKeepAlive => true;
  final iconList = <String>[MyAssets.svgs.icBell, MyAssets.svgs.icBell];
  final iconListSample = <IconData>[Icons.home_rounded, Icons.list_alt_rounded];

  List<Widget> _buildScreen() {
    return [HomePage(key: _homeNavKey), AllTaskPage(key: _allTaskNavKey)];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _cubit),
        BlocProvider.value(value: _themeCubit),
        BlocProvider.value(value: _homeCubit),
      ],
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          if (state is MainNavigation) {
            _controller.animateToPage(
              _cubit.currentPosition,
              duration: Const.DURATION_ANIMATION,
              curve: Const.EFFECT_ANIMATION,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: _buildScreen(),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: _themeCubit.appColors.primaryColor,
              shape: const CircleBorder(),
              child: Icon(
                Icons.add,
                color: _themeCubit.appColors.backgroundColor,
                size: 40.w,
              ),
              onPressed: () {
                NavigationUtils.navigatePage(context, DetailTaskPage()).then((
                  _,
                ) {
                  Future.wait([
                    _homeCubit.getAllTasks(isRefresh: true),
                    _homeCubit.getSpecialTasks(),
                  ]).then((_) {
                    _homeCubit.calculateDonePercentage();
                  });
                });
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar.builder(
              backgroundColor: _themeCubit.appColors.backgroundColor,
              itemCount: iconListSample.length,
              activeIndex: _cubit.currentPosition,
              height: 56.h,
              tabBuilder: (int index, bool isActive) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconListSample[index],

                      color:
                          isActive
                              ? _themeCubit.appColors.primaryColor
                              : _themeCubit.appColors.iconColor,
                    ),

                    6.verticalSpace,
                    Container(
                      height: 4.h,
                      width: 32.w,
                      decoration: BoxDecoration(
                        color:
                            isActive
                                ? _themeCubit.appColors.primaryColor
                                : null,
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      ),
                    ),
                  ],
                );
              },
              scaleFactor: 0.0,
              shadow: BoxShadow(
                // ignore: deprecated_member_use
                color: _themeCubit.appColors.textPrimary.withOpacity(.3),
                blurRadius: 4,
                offset: Offset(0, -1),
                spreadRadius: 0,
              ),
              leftCornerRadius: 24,
              rightCornerRadius: 24,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.smoothEdge,
              onTap: (index) {
                _cubit.onNavigateMainPage(index);
              },
              //other params
            ),
          );
        },
      ),
    );
  }
}
