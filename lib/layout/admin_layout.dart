import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa7a7/layout/amdin_layout/cubit/cubit.dart';
import 'package:sa7a7/layout/amdin_layout/cubit/states.dart';
import 'package:sa7a7/models/shared/componantes/back_ground2.dart';
import 'package:sa7a7/models/shared/componantes/constents.dart';
import 'package:sqflite/sqflite.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool isButtomSheetShown = false;
  late Database database;

  @override
  void initState() {
    // TODO: implement initState
    creatDataBase();
  }

  @override
  Widget build(BuildContext context1) {
    var cubit = AdminCubit.get(context);

    return BlocConsumer<AdminCubit, AdminStates>(
      builder: (BuildContext context, state) {
        return Background(
          child: Scaffold(
            key: cubit.scaffoldKey,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNaveBar(index);
              },
              items: cubit.bottomItems,
            ),
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: Visibility(
              visible: cubit.isVisable(cubit.currentIndex),
              child: FloatingActionButton(
                  onPressed: () {
                    if (isButtomSheetShown) {
                      insertToDataBase(
                              couseName: cubit.nameController.text,
                              courseId: cubit.idController.text,
                              courseLevel: cubit.levelController.text)
                          .then((value) {
                        getDataFromDataBase(database).then((value) {
                          Navigator.pop(context);
                          setState(() {
                            
                        isButtomSheetShown = false;
                            courses = value;
                          });
                        });
                        
                      });
                    } else {
                      cubit.scaffoldKey.currentState!
                          .showBottomSheet((context) {
                        if (cubit.currentIndex == 0) {
                          return cubit.ActionButtonCourse(context);
                        } else if (cubit.currentIndex == 1) {
                          return Container(
                            height: 100,
                            color: Colors.grey,
                          );
                        }
                        if (cubit.currentIndex == 2) {
                          return Container(
                            height: 100,
                            color: Colors.pink,
                          );
                        }
                        return cubit.screens[3];
                      });
                      isButtomSheetShown = true;
                    }
                  },
                  child: cubit.icons[cubit.currentIndex]),
            ),
          ),
        );
      },
      listener: (BuildContext context, state) {},
    );
  }

  void creatDataBase() async {
    database = await openDatabase(
      'courses.db',
      version: 1,
      onCreate: (database, version) async {
        print('Data Base Created');
        await database.execute(
            'CREATE TABLE courses (couseName TEXT,courseId TEXT,courseLevel INTEGER)');
      },
      onOpen: (database) async {
        print('Data Base opend');
      },
    );
  }

  Future insertToDataBase({
    required String couseName,
    required String courseId,
    required String courseLevel,
  }) async {
    await database.transaction(
      (txn) => txn
          .rawInsert(
              'INSERT INTO courses(couseName,courseId,courseLevel) VALUES ("$couseName","$courseId","$courseLevel")')
          .then((value) {
        print('$value Inserted successfully');
      }).catchError((error) {}),
    );
  }

  Future<List<Map>> getDataFromDataBase(database) async {
    return await database.rawQuery('SELECT * FROM courses');
  }
}
