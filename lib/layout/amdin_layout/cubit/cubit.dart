import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sa7a7/layout/amdin_layout/cubit/states.dart';
import 'package:sa7a7/models/add_edecatour/add_edecator.dart';
import 'package:sa7a7/models/add_students/add_students.dart';
import 'package:sa7a7/models/all_cources_page/action_logic_od_bottom_navi.dart';
import 'package:sa7a7/models/all_cources_page/all_courses.dart';
import 'package:sa7a7/models/setting_page/setting.dart';

// class AdminCubit extends Cubit<AdminStates> {
//   AdminCubit() : super(AdminInitialState());

//   static AdminCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

    // var scaffoldKey = GlobalKey<ScaffoldState>();

    var nameController = TextEditingController();
    var idController = TextEditingController();
    var levelController = TextEditingController();
    

   

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.book), label: 'All course'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.person), label: 'edecator'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.groups_rounded), label: 'students'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
  ];

  List<Widget> screens = [
    const AllCoursesScreen(),
    const AddEdecatorPage(),
    const AddStudentsPage(),
    const AdminSettingPage(),
  ];

  List<Icon> icons = [
    const Icon(Icons.note_add_rounded),
    const Icon(Icons.account_circle_rounded),
    const Icon(Icons.group_add_rounded),
    const Icon(Icons.person_pin_outlined),
  ];

  Widget ActionButtonCourse(BuildContext context) {


    return LogicOfBottomNavigationAction();
  }

  void changeBottomNaveBar(int index) {
    currentIndex = index;
    // emit(AdminBottomNafState());
  }

  bool isVisable(int index) {
    if (index == 3) {
      return false;
    }
    return true;
  }

   

 
// }
