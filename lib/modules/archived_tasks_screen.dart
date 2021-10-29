import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:to_do_last_version/shared/components/components.dart';
import 'package:to_do_last_version/shared/cubit/cubit.dart';
import 'package:to_do_last_version/shared/cubit/status.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 8),
                    child: Text(
                      'Archived',
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
                    itemCount: cubit.archivedTasks.length,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    staggeredTileBuilder: (index) {
                      return const StaggeredTile.fit(1);
                    },
                    itemBuilder: (context, index) {
                      return cubit.archivedTasks.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : buildTaskItem(
                              status: cubit.archivedTasks[index]['status'],
                              content: cubit.archivedTasks[index]['task'],
                              title: cubit.archivedTasks[index]['title'],
                              time: cubit.archivedTasks[index]['time'],
                              color: cubit.archivedTasks[index]['colorNumber'],
                              id: cubit.archivedTasks[index]['id'],
                              date: cubit.archivedTasks[index]['date'],
                              model: cubit.archivedTasks[index],
                              context: context,
                              index: index,
                              // status: '',
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
