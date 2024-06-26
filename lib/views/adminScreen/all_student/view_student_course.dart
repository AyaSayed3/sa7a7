import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
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
  bool isLoadingCS = true;
  DocumentReference? studentDoc;
  Future<void> getStudentData() async {
    isLoadingCS = true;
    try {
      studentDoc = await FirebaseFirestore.instance
          .collection('Students')
          .doc(widget.studentId);
      studentDoc?.get().then((value) async {
        Map<String, dynamic>? studentData =
            value.data() as Map<String, dynamic>?;
        // print(doctorData );
        print(studentData?['courses']);
        allStudentCourse = studentData?['courses'];
        addedAlreadyCoursesOfED.clear();
        // print("///////////////////////mM\\\\\\\\\\\\\\\\\\\\\\");
        // print(allEdecatorCourse?[0]["Level"]);
        // print(allEdecatorCourse?.length);
        // print("///////////////////////mM\\\\\\\\\\\\\\\\\\\\\\");

        setState(() {
          isLoadingCS = false;
        });

        // fetchDataAndCheckField(coursesId: studentData?['courses'] as List<dynamic>  );
      });
    } catch (e) {
      isLoadingCS = false;
      setState(() {});
    }

    setState(() {
      isLoadingCS = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getStudentData();
  }

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
                      studentId: widget.studentId,
                    )),
          );
        },
        child: const Icon(
          Icons.bookmark_added_sharp,
          size: 35,
        ),
      ),
      body: isLoadingCS
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                await getStudentData();
                setState(() {});
              },
              child: Background(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 160),
                  itemCount: allStudentCourse.length,
                  itemBuilder: (context, index) {
                    addedAlreadyCoursesOfED
                        .add((allStudentCourse[index]['Course_ID']));
                    print(
                        "///////////////////////addedAlreadyCourses student\\\\\\\\\\\\\\\\\\\\\\");
                    print("${addedAlreadyCoursesOfED}");
                    print(
                        "///////////////////////addedAlreadyCourses student\\\\\\\\\\\\\\\\\\\\\\");

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onLongPress: () {
                          AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.rightSlide,
                                  title: 'Worning',
                                  desc:
                                      'Are You Sure about Dlete this Course..',
                                  btnOkOnPress: () async {
                                    // await FirebaseFirestore.instance
                                    //     .collection('Edecatour')
                                    //     .doc(Courses?[index]['Uniq_ID'])
                                    //     .delete();
                                    deleteCoure(
                                        allStudentCourse[index]['Course_ID']);

                                    setState(() {});

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewStudentCourse(
                                                    studentId:
                                                        widget.studentId)));
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
                                  'assets/images/addcourseToStudent.jpg',
                                  height: 80,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${allStudentCourse[index]['Course_Name']}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // const SizedBox(width: 10),
                                Text(
                                  "${allStudentCourse[index]['Course_ID']}",
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
              ),
            ),
    );
  }

//List<Map<String , dynamic>>? courses =[] ;
// Future<void> fetchDataAndCheckField({required List<dynamic> coursesId}) async {
//   print("hello bobnaya");
//   courses =[] ;
//   try {
//     // Access the Firestore instance
//     FirebaseFirestore firestore = FirebaseFirestore.instance;

//     // Efficient filtering query (if applicable)
//     Query query = firestore.collection('Courses').where('Course_ID', whereIn: coursesId);
//     QuerySnapshot querySnapshot = await query.get();

//     querySnapshot.docs.forEach((e) {
//       print(e.data());
//       Map<String, dynamic>  temp = e.data() as Map<String, dynamic> ;
//       courses?.add( temp);

//     });
//     // Loop through documents and add matching ones to Courses
//     // for (var doc in querySnapshot.docs) {
//     //   var docData = doc.data() as Map<String, dynamic>;
//     //   var fieldValue = docData['Uniq_ID'];

//     //   if (fieldValue == element) {
//     //     Courses.add(doc);
//     //     print('Document ID: ${doc.id}, Field Value: $fieldValue');
//     //   }
//     // }

//     // Update state based on fetched data (if needed)
//     setState(() {
//       isLoadingCS = false;
//     });
//   } catch (error) {
//     // Handle specific errors (e.g., FirebaseException)
//     print('Error fetching data: $error');
//     // Update state based on error (if needed)
//     // setState(() {
//     //   // ...
//     // });
//   } finally {
//     // Perform cleanup tasks if necessary (e.g., indicating loading completion)
//     isLoadingCS = false; // Assuming this flag is used for loading state
//     setState(() {
//       // Update loading state if relevant
//     });
//   }

//   return; // Explicitly return to match function signature
// }

  Future<void> deleteCoure(String stringToRemove) async {
    try {
      // FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch the document
      DocumentSnapshot docSnapshot = await studentDoc!.get();

      if (!docSnapshot.exists) {
        print('Document does not exist!');
        return;
      }

      Map<String, dynamic>? doctorData =
          docSnapshot.data() as Map<String, dynamic>?;
      // Access the field containing the array (replace 'your_array_field' with actual field name)
      List<dynamic> existingArray = doctorData?['courses'] as List<dynamic>;

      // Remove the string (consider efficiency for large arrays)
      List<dynamic> newArray = [];
      existingArray.forEach((element) {
        print("<<<<<<<<<<<<$element>>>>>>>>>>>>>");

        if (element['Course_ID'] != stringToRemove) {
          newArray.add(element);
        }
      });
      print("<<<<<<<<<<<<$newArray>>>>>>>>>>>>>");

      // Update the document with the modified array
      await studentDoc?.update({
        'courses': newArray,
      });

      print('String removed successfully!');
    } catch (error) {
      print('Error removing string: $error');
    }
  }
}
