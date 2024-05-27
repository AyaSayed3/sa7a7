import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sa7a7/views/adminScreen/all_student/view_student_course.dart';
import 'package:sa7a7/views/adminScreen/amdin_layout/admin_layout.dart';

class AllStudentScreen extends StatefulWidget {
  const AllStudentScreen({
    super.key,
  });

  @override
  State<AllStudentScreen> createState() => _AllStudentScreenState();
}

class _AllStudentScreenState extends State<AllStudentScreen> {
  @override
  void initState() {
    super.initState();
    getstudentData(context: context).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingTOstudent
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewStudentCourse(
                                    studentId: studentData[index].id,
                                  )));
                    },
                    onLongPress: () {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.rightSlide,
                              title: 'Worning',
                              desc: 'Are You Sure about Dlete this Student..',
                              btnOkOnPress: () async {
                                await FirebaseFirestore.instance
                                    .collection('Students')
                                    .doc(studentData[index].id)
                                    .delete();
          
                                setState(() {});
          
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminHomePage()));
                              },
                              btnCancelOnPress: () {})
                          .show();
                    },
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/student.jpg',
                              height: 100,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${studentData[index]['Student_Name']}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        );
  }
}
