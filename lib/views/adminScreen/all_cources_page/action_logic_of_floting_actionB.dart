import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sa7a7/views/adminScreen/amdin_layout/admin_layout.dart';

class LogicOfFlotingActionBottom extends StatefulWidget {
  const LogicOfFlotingActionBottom({
    super.key,
  });

  @override
  State<LogicOfFlotingActionBottom> createState() =>
      _LogicOfFlotingActionBottomState();
}

class _LogicOfFlotingActionBottomState
    extends State<LogicOfFlotingActionBottom> {
  CollectionReference courses = FirebaseFirestore.instance.collection('Courses');

Future<void> addCourses() {
  // Get the static ID from the course ID text controller
  String staticId = idCourseController.text;

  // Set the document with the specified static ID
  return courses
      .doc(staticId)
      .set({
        'Course_Name': nameCourseController.text,
        'Course_ID': idCourseController.text,
        'Level': levelCourseController.text,
        'Uniq_ID': FirebaseAuth.instance.currentUser!.uid,
      })
      .then((value) {
        print("Course Added with ID: $staticId");
      })
      .catchError((error) => print("Failed to add Course: $error"));
}
 

  // bool isLoadingOfAdd = false;

  @override
  Widget build(BuildContext context) {
    return isLoading? const Center(child: CircularProgressIndicator()) :SizedBox(
      height: 350,
      child: SafeArea(
        child: Form(
          key: formKeyAddCourse,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                  controller: nameCourseController,
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
                const Spacer(flex: 2),
                Row(
                  children: [
                    Expanded(
                      child: defaultTextFromFiled(
                        controller: idCourseController,
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
                        controller: levelCourseController,
                        label: 'Level',
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
                const SizedBox(height: 30),
                defaultButton(
                  width: 200,
                  onPressedFunction: () async {
                    if (formKeyAddCourse.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      addCourses();

                      await getData(context: context).then((value) {
                        clearMethodOfFlotBottom();
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdminHomePage()));
                      });
                    }
                  },
                  text: 'Add',
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





  //  getData() async {
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Courses').get();
  //   dataCourse.addAll(querySnapshot.docs);
  //   isLoading = false;
  //   // setState(() {
      
  //   // });
    
  // }
