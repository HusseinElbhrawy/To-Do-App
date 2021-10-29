import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_last_version/shared/components/components.dart';
import 'package:to_do_last_version/shared/components/const.dart';
import 'package:to_do_last_version/shared/cubit/cubit.dart';
import 'package:to_do_last_version/shared/cubit/status.dart';

class AddNewTaskScreen extends StatelessWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);
  static var dateController = TextEditingController();
  static var timeController = TextEditingController();
  static var titleController = TextEditingController();
  static var contentController = TextEditingController();
  static var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var appCubit = AppCubit.get(context);
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
              ),
            ),
          ],
          title: Text(
            'New Task',
            style: TextStyle(
              color: appCubit.isDark ? Colors.white : Colors.deepOrange,
              fontSize: MediaQuery.of(context).size.height * KTextSize,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsetsDirectional.all(
            MediaQuery.of(context).size.width * 0.055,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title Must Not Be Empty';
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: appCubit.isDark ? Colors.white : Colors.black,
                    fontSize: MediaQuery.of(context).size.height * 0.024,
                  ),
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.deepOrange,
                  controller: titleController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: appCubit.isDark ? Colors.white : Colors.black,
                      fontSize: MediaQuery.of(context).size.height * 0.022,
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: 'Title...',
                  ),
                  maxLines: 2,
                  maxLength: 100,
                ),
                TextFormField(
                  style: TextStyle(
                    color: appCubit.isDark ? Colors.white : Colors.black,
                    fontSize: MediaQuery.of(context).size.height * 0.020,
                  ),
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.deepOrange,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write Your Task...',
                    hintStyle: TextStyle(
                        color: appCubit.isDark ? Colors.white : Colors.black,
                        fontSize: MediaQuery.of(context).size.height * 0.020,
                        fontWeight: FontWeight.w500),
                  ),
                  validator: (value) {},
                  controller: contentController,
                  maxLines: 5,
                ),
                Container(
                  color: Colors.grey.shade100,
                  margin: const EdgeInsetsDirectional.only(
                    top: 50.0,
                    bottom: 10.0,
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Date Must Not Be Empty';
                      }
                      return null;
                    },
                    readOnly: true,
                    keyboardType: TextInputType.datetime,
                    controller: dateController,
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.utc(DateTime.now().year + 2),
                      ).then(
                        (value) {
                          dateController.text =
                              DateFormat.yMMMd().format(value!);
                        },
                      );
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.date_range),
                      hintText: 'Task Date',
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey.shade100,
                  clipBehavior: Clip.none,
                  margin: const EdgeInsetsDirectional.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: TextFormField(
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Time Must Not Be Empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.datetime,
                    controller: timeController,
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then(
                        (value) {
                          timeController.text =
                              value!.format(context).toString();
                          print(value.format(context));
                        },
                      );
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.timer),
                      hintText: 'Task Time',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              await appCubit.insertIntoDatabase(
                title: titleController.text,
                task: contentController.text,
                date: dateController.text,
                time: timeController.text,
                colorNumber: appCubit.colorIndex,
              );
              Navigator.of(context).pop();
              titleController.text = '';
              contentController.text = '';
              dateController.text = '';
              timeController.text = '';
            }
          },
          child: const Icon(Icons.done),
        ),
        bottomNavigationBar: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            return BottomAppBar(
              color: appCubit.isDark ? const Color(0xff171D2D) : Colors.white,
              shape: const CircularNotchedRectangle(),
              elevation: 50.0,
              notchMargin: appCubit.isDark
                  ? MediaQuery.of(context).size.height * 0.010
                  : MediaQuery.of(context).size.height * 0.010,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.155,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: appCubit.colors.length,
                  itemBuilder: (context, index) {
                    return ColorItem(
                      cubit: appCubit,
                      index: index,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
