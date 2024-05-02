import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/views/adminScreen/all_student/add_course_to_student.dart';
import 'package:sa7a7/views/adminScreen/amdin_layout/admin_layout.dart';

class ViewStudentCourse extends StatefulWidget {
  final String studentId;
  const ViewStudentCourse({
    super.key,
    required this.studentId,
  });

  @override
  State<ViewStudentCourse> createState() => _ViewStudentCourseState();
}

class _ViewStudentCourseState extends State<ViewStudentCourse> {
  
 
List<QueryDocumentSnapshot> studentData = [];


Future<void> getstudentData({required BuildContext context}) async {
  studentData = [];

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('Students').get();

  studentData.addAll(querySnapshot.docs);
  isLoadingCS = false;
}

  @override
  void initState() {
    super.initState();
    getstudentData(context: context).then((value) {
      setState(() {});
    });
  }
 bool isLoadingCS = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student course'),
        elevation: null,
        backgroundColor: Colors.transparent,
        leading: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminHomePage()),
            );
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddCourseToStudent(
                      docId: widget.studentId,
                    )),
          );
        },
        child: Icon(
          Icons.bookmark_added_sharp,
          size: 35,
        ),
      ),
      body: isLoadingCS
          ? const Center(child: CircularProgressIndicator())
          : Background(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 160),
                itemCount: studentData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onLongPress: () {
                        AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                title: 'Worning',
                                desc: 'Are You Sure about Dlete this Course..',
                                btnOkOnPress: () async {
                                  // await FirebaseFirestore.instance
                                  //     .collection('Edecatour')
                                  //     .doc(edecatourData[index].id)
                                  //     .delete();
            
                                  // setState(() {});
            
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const AdminHomePage()));
                                },
                                btnCancelOnPress: () {})
                            .show();
                      },
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: const Column(
                            children: [
                              SizedBox(height: 10),
                              // Text(
                              //   "${edecatourData[index]['Course']}",
                              //   overflow: TextOverflow.ellipsis,
                              // ),
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ),
    );
  }
}
