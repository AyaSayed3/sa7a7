import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sa7a7/views/adminScreen/all_cources_page/action_logic_of_floting_actionB.dart';
import 'package:sa7a7/views/adminScreen/all_cources_page/all_courses.dart';
import 'package:sa7a7/views/adminScreen/all_edecatour/all_edecator.dart';
import 'package:sa7a7/views/adminScreen/all_student/all_students.dart';
import 'package:sa7a7/views/adminScreen/setting_profile/setting_profile.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.book), label: 'All course'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Edecator'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.groups_rounded), label: 'Students'),
    const BottomNavigationBarItem(icon: Icon(Icons.personal_injury), label: 'Profile'),
  ];
  int currentIndex = 0;
  List<Widget> screens = [
    const AllCoursesScreen(),
    const AllEdecatourScreen(),
    const AllStudentScreen(),
    const AdminProfilePage(),
  ];

  List<Icon> icons = [
    const Icon(Icons.note_add_rounded),
    const Icon(Icons.account_circle_rounded),
    const Icon(Icons.group_add_rounded),
    const Icon(Icons.person_pin_outlined),
  ];

  // ignore: non_constant_identifier_names
  Widget ActionButtonCourse(BuildContext context) {
    return const LogicOfFlotingActionBottom();
  }

  void changeBottomNaveBar(int index) {
    currentIndex = index;
    // emit(AdminBottomNafState());
  }

  bool isVisable(int index) {
    if (index == 3 || index == 2 || index == 1) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context1) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    // var cubit = Adminget(context);

    return Background(
      child: Scaffold(
        appBar: AppBar(),
        key: scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            isButtomSheetShown = false;
            changeBottomNaveBar(index);
            setState(() {});
          },
          items: bottomItems,
        ),
        floatingActionButton: Visibility(
          visible: isVisable(currentIndex),
          child: FloatingActionButton(
              onPressed: () {
                if (isButtomSheetShown) {
                  //  Navigator.pop(context);
                  setState(() {
                    isButtomSheetShown = false;
                  });
                } else {
                  scaffoldKey.currentState!.showBottomSheet((context) {
                    if (currentIndex == 0) {
                      return ActionButtonCourse(context);
                    }
                
                    return screens[3];
                  });
                  isButtomSheetShown = true;
                }
              },
              child: icons[currentIndex]),
        ),
        body: screens[currentIndex],
      ),
    );
  }
}
