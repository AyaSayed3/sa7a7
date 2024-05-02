import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sa7a7/views/adminScreen/all_cources_page/update_course.dart';
import 'package:sa7a7/views/adminScreen/all_student/view_student_course.dart';

class AddCourseToStudent extends StatefulWidget {
  final String docId;
  const AddCourseToStudent({
    super.key,
    required this.docId,
  });

  @override
  State<AddCourseToStudent> createState() => _AddCourseToStudentState();
}

class _AddCourseToStudentState extends State<AddCourseToStudent> {
  @override
  void initState() {
    super.initState();
    getData(context: context).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Background(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 160),
                itemCount: dataCourse.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: 'Worning',
                          desc: '=> Are you Sure About Adding this Course ? <=.',
            
                          // btnCancelOnPress: () async {
                          //   await FirebaseFirestore.instance
                          //       .collection('Courses')
                          //       .doc(dataCourse[index].id)
                          //       .delete();
            
                          //   setState(() {});
            
                          //   Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => const AdminHomePage()));
                          // },
                          btnOkText: 'Add',
                          btnOkOnPress: () {
                            //معملتش لسه الفانكشن بتاع الفايربيز اللي تضفلي الكورس ل الدكتور
            
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => UpdatCourseData(
                            //         docId: dataCourse[index].id,
                            //         oldLevel: dataCourse[index]['Level'],
                            //         oldId: dataCourse[index]['Course_ID'],
                            //         oldName: dataCourse[index]['Course_Name'],
                            //       ),
                            //     ));
                          },
                        ).show();
                      },
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
                                .doc(dataCourse[index].id)
                                .delete();
                                isLoading=true;
                            setState(() {});
            
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  ViewStudentCourse(studentId: widget.docId , )));
                          },
                          
                          btnOkText: 'Edit',
                          btnOkOnPress: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdatCourseData(
                                    docId: dataCourse[index].id,
                                    oldLevel: dataCourse[index]['Level'],
                                    oldId: dataCourse[index]['Course_ID'],
                                    oldName: dataCourse[index]['Course_Name'],
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${dataCourse[index]['Course_Name']}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    " Level ${dataCourse[index]['Level']}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
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
