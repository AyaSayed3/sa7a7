import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sa7a7/views/adminScreen/amdin_layout/admin_layout.dart';

class UpdatCourseData extends StatefulWidget {
  final String docId;
  final String oldName;
  final String oldId;
  final String oldLevel;

  const UpdatCourseData({
    super.key,
    required this.docId,
    required this.oldName,
    required this.oldId,
    required this.oldLevel,
  });

  @override
  State<UpdatCourseData> createState() => _UpdatCourseDataState();
}

class _UpdatCourseDataState extends State<UpdatCourseData> {
  CollectionReference courses =
      FirebaseFirestore.instance.collection('Courses');
  upDateCourses() async {
    try {
      await courses.doc(widget.docId).update({
        'Course_Name': nameCourseController.text,
        'Course_ID': idCourseController.text,
        'Level': levelController.text,
      });
      // .then((value) => print("Course Up Dated"))
    } catch (e) {
      print("Failed to Up Dated Course: $e");
    }
  }

  @override
  void initState() {
    nameCourseController.text = widget.oldName;
    idCourseController.text = widget.oldId;
    levelController.text = widget.oldLevel;
  
    super.initState();
  }

  bool isLoadingOfAdd = false;
  var formKeyUpdateCourse = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return isLoadingOfAdd
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
         appBar: AppBar(),
          body: Background(
            child: SafeArea(
              child: Form(
                key: formKeyUpdateCourse,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        'UpDate  Courses',
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
                      const Spacer(flex: 1),
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
                        onPressedFunction: () async {
                          if (formKeyUpdateCourse.currentState!.validate()) {
                            isLoadingOfAdd = true;
                            setState(() {});
                            upDateCourses();
                    
                            await getData(context: context).then((value) {
                              clearMethodOfFlotBottom();
                              isLoadingOfAdd = false;
                              setState(() {});
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminHomePage()));
                            });
                          }
                        },
                        text: 'UpDate',
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
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
