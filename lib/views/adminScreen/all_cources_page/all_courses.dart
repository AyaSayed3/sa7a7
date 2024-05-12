import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sa7a7/views/adminScreen/all_cources_page/update_course.dart';
import 'package:sa7a7/views/adminScreen/amdin_layout/admin_layout.dart';

class AllCoursesScreen extends StatefulWidget {
  const AllCoursesScreen({
    super.key,
  });

  @override
  State<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen> {
  @override
  void initState() {

    super.initState();
    getData(context: context).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Background(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 160),
              itemCount: dataCourses.length,
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
                        desc: '=> Choose Whate do you want to do ? <=.',
                        btnCancelText: 'Delet',
                        btnCancelOnPress: () async {
                          await FirebaseFirestore.instance
                              .collection('Courses')
                              .doc(dataCourses[index].id)
                              .delete();
          
                          setState(() {});
          
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AdminHomePage()));
                        },
                        btnOkText: 'Edit',
                        btnOkOnPress: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdatCourseData(
                                  docId: dataCourses[index].id,
                                  oldLevel: dataCourses[index]['Level'],
                                  oldId: dataCourses[index]['Course_ID'],
                                  oldName: dataCourses[index]['Course_Name'],
                                ),
                              ));
                              
                        },
                      ).show();
                    },
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/files.png',
                              height: 100,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${dataCourses[index]['Course_Name']}",
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
