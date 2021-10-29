import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:to_do_last_version/shared/components/components.dart';
import 'package:to_do_last_version/shared/cubit/cubit.dart';
import 'package:to_do_last_version/shared/cubit/status.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({Key? key}) : super(key: key);

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
                    'Tasks',
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
                  itemCount: cubit.newTasks.length,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  staggeredTileBuilder: (index) {
                    return const StaggeredTile.fit(1);
                  },
                  itemBuilder: (context, index) {
                    return cubit.newTasks.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : buildTaskItem(
                            status: cubit.newTasks[index]['status'],
                            model: cubit.newTasks[index],
                            index: index,
                            context: context,
                            content: cubit.newTasks[index]['task'],
                            title: cubit.newTasks[index]['title'],
                            time: cubit.newTasks[index]['time'],
                            color: cubit.newTasks[index]['colorNumber'],
                            id: cubit.newTasks[index]['id'],
                            date: cubit.newTasks[index]['date'],
                          );
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
