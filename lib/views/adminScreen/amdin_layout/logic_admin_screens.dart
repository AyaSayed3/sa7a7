import 'package:flutter/material.dart';
import 'package:sa7a7/views/adminScreen/add_edecatour/add_edecator.dart';
import 'package:sa7a7/views/adminScreen/add_students/add_students.dart';
import 'package:sa7a7/views/adminScreen/all_cources_page/action_logic_of_floting_actionB.dart';
import 'package:sa7a7/views/adminScreen/all_cources_page/all_courses.dart';
import 'package:sa7a7/models/setting_page/setting.dart';

  int currentIndex = 0;


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
    const AddCourseToEdecatourScreen(),
    const AddCourseToStudentScreen(),
    const AdminSettingPage(),
  ];

  List<Icon> icons = [
    const Icon(Icons.note_add_rounded),
    const Icon(Icons.account_circle_rounded),
    const Icon(Icons.group_add_rounded),
    const Icon(Icons.person_pin_outlined),
  ];

  Widget ActionButtonCourse(BuildContext context) {


    return const LogicOfFlotingActionBottom();
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

   

 

