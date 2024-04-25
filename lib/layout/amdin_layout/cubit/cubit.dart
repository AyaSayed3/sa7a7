import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa7a7/layout/amdin_layout/cubit/states.dart';
import 'package:sa7a7/models/add_edecatour/add_edecator.dart';
import 'package:sa7a7/models/add_students/add_students.dart';
import 'package:sa7a7/models/all_cources_page/all_courses.dart';
import 'package:sa7a7/models/setting_page/setting.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sqflite/sqflite.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitialState());

  static AdminCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
      var nameController = TextEditingController();
    var idController = TextEditingController();
    var levelController = TextEditingController();
    late Database database;

   

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.book), label: 'All course'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.person), label: 'edecator'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.groups_rounded), label: 'students'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
  ];

  List<Widget> screens = [
    const AllCoursesPage(),
    const AddEdecatorPage(),
    const AddStudentsPage(),
    const AdminSettingPage(),
  ];
  // List<FloatingActionButton> floatingactionbottom = [
  //   FloatingActionButton(
  //       onPressed: () { }, child: const Icon(Icons.note_add_rounded)),
  //   FloatingActionButton(
  //       onPressed: () {}, child: const Icon(Icons.account_circle_rounded)),
  //   FloatingActionButton(
  //       onPressed: () {}, child: const Icon(Icons.group_add_rounded)),
  //   FloatingActionButton(
  //       onPressed: () {}, child: const Icon(Icons.person_pin_outlined)),
  // ];
  List<Icon> icons = [
    const Icon(Icons.note_add_rounded),
    const Icon(Icons.account_circle_rounded),
    const Icon(Icons.group_add_rounded),
    const Icon(Icons.person_pin_outlined),
  ];

  Widget ActionButtonCourse(BuildContext context) {


    var formKey = GlobalKey<FormState>();
    return Container(
      height: 300,
      // width: double.infinity,
      child: Form(
        key: formKey,
        child: Padding(
          padding:  EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Add Courses',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              defaultTextFromFiled(
                controller: nameController,
                label: 'Course Name',
                keyboardType: TextInputType.text,
                prefix: Icons.menu_book_sharp,
                vlidator: (value) {
                  if (value.isEmpty) {
                    return 'course Name must be not empty';
                  }
                  return null;
                },
              ),
              const Spacer(flex: 1),
              Row(
                children: [
                  Expanded(
                    child: defaultTextFromFiled(
                      controller: idController,
                      label: 'course ID',
                      keyboardType: TextInputType.text,
                      prefix: Icons.vpn_lock_sharp,
                      vlidator: (value) {
                        if (value.isEmpty) {
                          return 'course ID must be not empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: defaultTextFromFiled(
                      controller: levelController,
                      label: 'course\'s Level',
                      keyboardType: TextInputType.number,
                      prefix: Icons.star_rounded,
                      vlidator: (value) {
                        if (value.isEmpty) {
                          return 'course\'s Level must be not empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              
              // defaultButton(
              //   width: 200,
              //   onPressedFunction: () {
                  
              //     if (formKey.currentState!.validate()) {
              //       Navigator.pop(
              //           context  ,
              //           MaterialPageRoute(
              //             builder: (context) => AllCoursesPage(
              //             ),
              //           ));
              //           emit(AddCouresState());
                        
              //     }
                

              //   },
              //   text: 'Add',
              // ),
              // const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  void changeBottomNaveBar(int index) {
    currentIndex = index;
    emit(AdminBottomNafState());
  }

  bool isVisable(int index) {
    if (index == 3) {
      return false;
    }
    return true;
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
      onOpen: (database) {
        print('Data Base opend');
      },
    );
  }

  void insertToDataBase() {
    database.transaction(
      (txn) => txn
          .rawInsert(
              'INSERT INTO courses(couseName,courseId,courseLevel) VALUES ("ai","fci305","3")')
          .then((value) {
            print('$value Inserted successfully');
          })
          .catchError((error) {}),
    );
  }
}
