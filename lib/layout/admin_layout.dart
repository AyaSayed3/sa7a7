import 'package:flutter/material.dart';
import 'package:sa7a7/layout/amdin_layout/cubit/cubit.dart';
import 'package:sa7a7/models/shared/componantes/back_ground2.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sqflite/sqflite.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  
  late Database database;

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
                changeBottomNaveBar(index);
                setState(() {
                  
                });
              },
              items: bottomItems,
            ),
             floatingActionButton: Visibility(
              visible: isVisable(currentIndex),
              child: FloatingActionButton(
                  onPressed: () {



                    
                    if (isButtomSheetShown) {
                      
                         Navigator.pop(context);
                          setState(() {
                            
                        isButtomSheetShown = false;
                           
                          });
                    } else {
                      scaffoldKey.currentState!.showBottomSheet((context) {
    //                      showModalBottomSheet(
    //   backgroundColor: Colors.white,
    //   shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
    //   context: context,
    //   builder: (context) {
       
    //   },
    // );
                        if (currentIndex == 0) {
                          return ActionButtonCourse(context);
                        } else if (currentIndex == 1) {
                          return Container(
                            height: 100,
                            color: Colors.grey,
                          );
                        }
                        if (currentIndex == 2) {
                          return Container(
                            height: 100,
                            color: Colors.pink,
                          );
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
