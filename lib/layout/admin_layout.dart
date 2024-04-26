import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa7a7/layout/amdin_layout/cubit/cubit.dart';
import 'package:sa7a7/layout/amdin_layout/cubit/states.dart';
import 'package:sa7a7/models/shared/componantes/back_ground2.dart';
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
    super.initState();
   
  }

  @override
  Widget build(BuildContext context1) {
    var cubit = AdminCubit.get(context);

    return BlocConsumer<AdminCubit, AdminStates>(
      builder: (BuildContext context, state) {
        return Background(
          child: Scaffold(
            appBar: AppBar(),
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
                      
                         Navigator.pop(context);
                          setState(() {
                            
                        isButtomSheetShown = false;
                           
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

 

  

  
}
