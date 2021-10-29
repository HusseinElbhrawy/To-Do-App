import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_last_version/modules/tasks/add_new_task_screen.dart';
import 'package:to_do_last_version/shared/components/components.dart';
import 'package:to_do_last_version/shared/components/const.dart';
import 'package:to_do_last_version/shared/cubit/cubit.dart';
import 'package:to_do_last_version/shared/cubit/status.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing:
                MediaQuery.of(context).size.height * KPaddingFormStart,
            title: Text(
              'Reminders',
              style: TextStyle(
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height * 0.035,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddNewTaskScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.add,
                  color: appCubit.isDark ? Colors.white : Colors.deepOrange,
                  size: MediaQuery.of(context).size.height * 0.035,
                ),
              ),
              IconButton(
                onPressed: () {
                  appCubit.changeAppMode();
                },
                icon: Icon(
                  Icons.brightness_4_outlined,
                  color: appCubit.isDark ? Colors.white : Colors.deepOrange,
                  size: MediaQuery.of(context).size.height * 0.035,
                ),
              ),
            ],
            automaticallyImplyLeading: false,
          ),
          bottomNavigationBar: CurvedNavigationBar(
            buttonBackgroundColor:
                appCubit.isDark ? Colors.white : Colors.white,
            color: appCubit.isDark ? Color(0xff171D2D) : Colors.white,
            backgroundColor: appCubit.isDark ? Colors.white : Colors.deepOrange,
            items: iList(context),
            onTap: (index) {
              appCubit.changeIndexOfScreen(index);
            },
          ),
          body: appCubit.allScreens[appCubit.currentIndex],
        );
      },
    );
  }
}
