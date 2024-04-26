
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/all_cources_page/all_courses.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';

class LogicOfBottomNavigationAction extends StatefulWidget {
  const LogicOfBottomNavigationAction({
    super.key,
    required this.nameController,
    required this.idController,
    required this.levelController,
  });

  final TextEditingController nameController;
  final TextEditingController idController;
  final TextEditingController levelController;

  @override
  State<LogicOfBottomNavigationAction> createState() => _LogicOfBottomNavigationActionState();
}

class _LogicOfBottomNavigationActionState extends State<LogicOfBottomNavigationAction> {



   CollectionReference courses = FirebaseFirestore.instance.collection('Courses');
    Future<void> addCourses() {
     
      return courses
          .add({
            'Course_Name': nameController.text, 
            'Course_ID': idController.text, 
            'Level': levelController.text 
          })
          .then((value) => print("Course Added"))
          .catchError((error) => print("Failed to add Course: $error"));
    }




  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return SizedBox(
      height: 300,
      // width: double.infinity,
      child: Form(
        key: formKey,
        child: Padding(
          padding:  const EdgeInsets.all(20.0),
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
               const SizedBox(height: 30),
              defaultButton(
                width: 200,
                onPressedFunction: () {
                  
                  if (formKey.currentState!.validate()) {
                    addCourses();
                    Navigator.pop(
                        context  ,
                        MaterialPageRoute(
                          builder: (context) => const AllCoursesPage(
                          ),
                        ));
                        
                  }
                
    
                },
                text: 'Add',
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
