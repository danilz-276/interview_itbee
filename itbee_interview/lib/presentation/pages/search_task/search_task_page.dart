import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itbee_interview/configuration/app_styles.dart';
import 'package:itbee_interview/configuration/gen/assets.gen.dart';
import 'package:itbee_interview/injection_container.dart';
import 'package:itbee_interview/presentation/pages/detail_task/detail_task_page.dart';
import 'package:itbee_interview/presentation/pages/search_task/cubit/search_task_cubit.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';
import 'package:itbee_interview/presentation/widgets/card_detail_task.dart';
import 'package:itbee_interview/presentation/widgets/singletap_detector.dart';
import 'package:itbee_interview/utils/navigation.dart';

class SearchTaskPage extends StatelessWidget {
  SearchTaskPage({super.key});
  final themeCurrent = getIt<ThemeCubit>();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchTaskCubit(),
      child: BlocBuilder<SearchTaskCubit, SearchTaskState>(
        builder: (context, state) {
          var cubit = context.read<SearchTaskCubit>();
          return Scaffold(
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 8.h,
                    top: MediaQuery.of(context).viewPadding.top + 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: themeCurrent.appColors.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: themeCurrent.appColors.textPrimary.withOpacity(
                          .3,
                        ),
                        offset: Offset(0, 1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SingleTapDetector(
                        onTap: () {
                          NavigationUtils.popPage(context);
                        },
                        child: SvgPicture.asset(
                          MyAssets.svgs.icArrowLeft,
                          height: 20.w,
                          width: 20.w,
                          colorFilter: ColorFilter.mode(
                            themeCurrent.appColors.textPrimary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: TextField(
                          controller: textEditingController,

                          onChanged: (value) {
                            cubit.searchTasks(value);
                          },
                          enableSuggestions: false,
                          style: Theme.of(
                            context,
                          ).textTheme.text14w500.copyWith(
                            color: themeCurrent.appColors.textPrimary,
                          ),

                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Nhập tên task',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8.h,
                              horizontal: 8.w,
                            ),
                            // alignLabelWithHint: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child:
                      cubit.listTask.isEmpty
                          ? Center(
                            child: Image.asset(
                              MyAssets.pngs.empty.path,
                              height: 120.h,
                              width: 120.w,
                            ),
                          )
                          : SingleChildScrollView(
                            child: Column(
                              children: List.generate(cubit.listTask.length, (
                                index,
                              ) {
                                return CardDetailTask(
                                  press: () {
                                    NavigationUtils.navigatePage(
                                      context,
                                      DetailTaskPage(
                                        id: cubit.listTask[index].id,
                                      ),
                                    ).then((_) {
                                      cubit.searchTasks(
                                        textEditingController.text,
                                      );
                                    });
                                  },
                                  themeCurrent: themeCurrent,
                                  isLast: index == cubit.listTask.length - 1,
                                  data: cubit.listTask[index],
                                );
                              }),
                            ),
                          ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
