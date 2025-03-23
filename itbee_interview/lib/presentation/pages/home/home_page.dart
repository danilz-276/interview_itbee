import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itbee_interview/configuration/app_styles.dart';
import 'package:itbee_interview/configuration/gen/assets.gen.dart';
import 'package:itbee_interview/injection_container.dart';
import 'package:itbee_interview/localization/strings.dart';
import 'package:itbee_interview/presentation/pages/detail_task/detail_task_page.dart';
import 'package:itbee_interview/presentation/pages/home/cubit/home_cubit.dart';
import 'package:itbee_interview/presentation/pages/home/widgets/card_in_progress.dart';
import 'package:itbee_interview/presentation/pages/home/widgets/filter_task.dart';
import 'package:itbee_interview/presentation/pages/home/widgets/title_with_number.dart';
import 'package:itbee_interview/presentation/pages/main/cubit/main_cubit.dart';
import 'package:itbee_interview/presentation/pages/search_task/search_task_page.dart';
import 'package:itbee_interview/presentation/pages/setting/setting_page.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';
import 'package:itbee_interview/presentation/widgets/card_detail_task.dart';
import 'package:itbee_interview/presentation/widgets/singletap_detector.dart';
import 'package:itbee_interview/utils/navigation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/card_total_doing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final themeCurrent = getIt<ThemeCubit>();
  late HomeCubit _cubit;
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    getData();
  }

  getData() async {
    Future.wait([
      _cubit.getAllTasks(isRefresh: true),
      _cubit.getSpecialTasks(),
    ]).then((_) {
      _cubit.calculateDonePercentage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeCurrent = getIt<ThemeCubit>();
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeGetDataDone) {
            _refreshController.refreshCompleted();
            _refreshController.loadComplete();
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SmartRefresher(
              controller: _refreshController,
              enablePullUp: _cubit.canLoadMore,
              onRefresh: () {
                _cubit.getAllTasks(isRefresh: true);
                _refreshController.requestRefresh();
              },
              onLoading: () {
                _cubit.getAllTasks(isLoadMore: true);
                _refreshController.requestLoading();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: themeCurrent.appColors.textPrimary,
                            ),
                            height: 32.w,
                            width: 32.w,
                            child: Icon(
                              Icons.person_2,
                              color: themeCurrent.appColors.primaryColor,
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Strings.hello,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.text12w400.copyWith(
                                    color: themeCurrent.appColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  Strings.whatIsYourName,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.text14w400.copyWith(
                                    color: themeCurrent.appColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          8.horizontalSpace,

                          SingleTapDetector(
                            onTap: () {
                              NavigationUtils.navigatePage(
                                context,
                                SearchTaskPage(),
                              ).then((_) {
                                getData();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              height: 24.w,
                              width: 24.w,
                              child: Icon(
                                Icons.manage_search_sharp,
                                color: themeCurrent.appColors.textPrimary,
                              ),
                            ),
                          ),
                          8.horizontalSpace,

                          SingleTapDetector(
                            onTap: () {
                              NavigationUtils.navigatePage(
                                context,
                                SettingPage(),
                              ).then((_) {
                                getData();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              height: 24.w,
                              width: 24.w,
                              child: Icon(
                                Icons.settings,

                                color: themeCurrent.appColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    12.verticalSpace,
                    CardTotalDoing(
                      themeCurrent: themeCurrent,
                      percent: _cubit.percentDoneToday,
                      press: () {
                        getIt<MainCubit>().onNavigateMainPage(1);
                      },
                    ),
                    12.verticalSpace,
                    TitleWithNumber(
                      themeCurrent: themeCurrent,
                      title: Strings.tasksInProgress,
                      number: _cubit.listTaskInProgress.length,
                    ),
                    12.verticalSpace,
                    if (_cubit.listTaskInProgress.isEmpty) ...[
                      Image.asset(
                        MyAssets.pngs.empty.path,
                        height: 120.h,
                        width: 120.w,
                      ),
                    ] else ...[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            _cubit.listTaskInProgress.length,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: 16.w,
                                  right: index == 11 ? 16.w : 0,
                                ),
                                child: CardInProgress(
                                  press: () {},
                                  themeCurrent: themeCurrent,
                                  groupName:
                                      _cubit.listTaskInProgress[index].title,
                                  color: themeCurrent.appColors.progressBlue,
                                  percent: 0,
                                  title:
                                      _cubit
                                          .listTaskInProgress[index]
                                          .description ??
                                      '',
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],

                    12.verticalSpace,
                    TitleWithNumber(
                      themeCurrent: themeCurrent,
                      title: Strings.taskList,
                      number: _cubit.totalCount,
                      press: () {
                        _filterBottomsheet(context);
                      },
                    ),
                    12.verticalSpace,
                    if (_cubit.listTaskAll.isEmpty) ...[
                      Image.asset(
                        MyAssets.pngs.empty.path,
                        height: 120.h,
                        width: 120.w,
                      ),
                    ] else ...[
                      ...List.generate(_cubit.listTaskAll.length, (index) {
                        return CardDetailTask(
                          press: () {
                            NavigationUtils.navigatePage(
                              context,
                              DetailTaskPage(id: _cubit.listTaskAll[index].id),
                            ).then((_) {
                              getData();
                            });
                          },
                          themeCurrent: themeCurrent,
                          isLast: index == _cubit.listTaskAll.length - 1,
                          data: _cubit.listTaskAll[index],
                        );
                      }),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _filterBottomsheet(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
      ),
      scrollControlDisabledMaxHeightRatio: 0.87,
      backgroundColor: themeCurrent.appColors.backgroundColor,
      context: context,
      builder: (BuildContext context) {
        return FilterTask(
          data: _cubit.statusTemp,
          callback: (p0) {
            _cubit.saveStatusTemp(p0);
          },
        );
      },
    ).then((_) {
      _cubit.getAllTasks(isRefresh: true);
    });
  }
}
