import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:to_do_last_version/shared/components/components.dart';
import 'package:to_do_last_version/shared/cubit/cubit.dart';
import 'package:to_do_last_version/shared/cubit/status.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 8),
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: AppCubit.get(context).isDark
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.022,
                    ),
                  ),
                ),
                StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  itemCount: cubit.doneTasks.length,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  staggeredTileBuilder: (index) {
                    return const StaggeredTile.fit(1);
                  },
                  itemBuilder: (context, index) {
                    if (cubit.doneTasks.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return buildTaskItem(
                        status: cubit.doneTasks[index]['status'],
                        content: cubit.doneTasks[index]['task'],
                        title: cubit.doneTasks[index]['title'],
                        time: cubit.doneTasks[index]['time'],
                        color: cubit.doneTasks[index]['colorNumber'],
                        id: cubit.doneTasks[index]['id'],
                        date: cubit.doneTasks[index]['date'],
                        model: cubit.doneTasks[index],
                        context: context,
                        index: index,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
