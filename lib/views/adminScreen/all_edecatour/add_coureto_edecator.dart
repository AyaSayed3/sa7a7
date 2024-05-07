import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sa7a7/views/adminScreen/all_cources_page/update_course.dart';
import 'package:sa7a7/views/adminScreen/all_edecatour/view_edecatour_course.dart';

// class AddCourseToEdecatour extends StatefulWidget {
//   final String docId;
//   const AddCourseToEdecatour({
//     super.key,
//     required this.docId,
//   });

//   @override
//   State<AddCourseToEdecatour> createState() => _AddCourseToEdecatourState();
// }

// class _AddCourseToEdecatourState extends State<AddCourseToEdecatour> {

// var nameCourseController = TextEditingController();
// var idCourseController = TextEditingController();
// var levelCourseController = TextEditingController();

//   Future<void> addCourses() {
//     CollectionReference coursesToedecatour = FirebaseFirestore.instance
//         .collection('Edecatour')
//         .doc(widget.docId)
//         .collection('Course');
//     return coursesToedecatour
//         .add({
//           'name': nameCourseController.text,
//           'id': idCourseController.text,
//           'level': levelCourseController.text,
//          // 'Uniq_ID': FirebaseAuth.instance.currentUser!.uid,
//         })
//         .then((value) => print("Course Added"))
//         .catchError((error) => print("Failed to add Course: $error"));
//   }

//   bool isLoadingOfAdd = false;
//   var formKeyAddCourseToEdecatour = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return isLoadingOfAdd
//         ? const Center(child: CircularProgressIndicator())
//         : Background(
//             child: Scaffold(
//               appBar: AppBar(
//                   elevation: null,
//                   backgroundColor: Colors.transparent,
//                   leading: TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const AdminHomePage()));
//                     },
//                     child: const Icon(
//                       Icons.arrow_back_ios_rounded,
//                       color: Colors.black,
//                     ),
//                   )),
//               body: SafeArea(
//                 child: Form(
//                   key: formKeyAddCourseToEdecatour,
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),

//                   ),
//                 ),
//               ),
//             ),
//           );
//   }
// }

class AddCourseToEdecatour extends StatefulWidget {
  final String docId;
  const AddCourseToEdecatour({
    super.key,
    required this.docId,
  });

  @override
  State<AddCourseToEdecatour> createState() => _AddCourseToEdecatourState();
}

class _AddCourseToEdecatourState extends State<AddCourseToEdecatour> {
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
                itemCount: dataCourses.length,
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
                                .doc(dataCourses[index].id)
                                .delete();
                                isLoading=true;
                            setState(() {});
            
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  ViewEdecatourCourse(EdecatourId: widget.docId , )));
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${dataCourses[index]['Course_Name']}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${dataCourses[index]['Level']}",
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
