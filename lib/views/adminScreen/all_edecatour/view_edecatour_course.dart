import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sa7a7/views/adminScreen/all_edecatour/add_coureto_edecator.dart';
import 'package:sa7a7/views/adminScreen/amdin_layout/admin_layout.dart';

class ViewEdecatourCourse extends StatefulWidget {
  final String edecatourId;
  const ViewEdecatourCourse({
    super.key,
    required this.edecatourId,
  });

  @override
  State<ViewEdecatourCourse> createState() => _ViewEdecatourCourseState();
}

class _ViewEdecatourCourseState extends State<ViewEdecatourCourse> {
  bool isLoadingECV = true;
  DocumentReference? doctorDoc;
  Future<void> getDoctorData() async {
    isLoadingECV = true;
    try {
      doctorDoc = await FirebaseFirestore.instance
          .collection('Edecatour')
          .doc(widget.edecatourId);
      doctorDoc?.get().then((value) async {
        Map<String, dynamic>? doctorData =
            value.data() as Map<String, dynamic>?;
       
        allEdecatorCourse = doctorData?['courses'];
          addedAlreadyCoursesOfED.clear();

        setState(() {
          isLoadingECV = false;
        });
      });
    } catch (e) {
      isLoadingECV = false;
      setState(() {});
    }

    setState(() {
      isLoadingECV = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getDoctorData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edecatour course'),
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
                builder: (context) => AddCourseToEdecatour(
                      docId: widget.edecatourId,
                    )),
          );
        },
        child: const Icon(
          Icons.bookmark_added_sharp,
          size: 35,
        ),
      ),
      body: isLoadingECV
          ? const Center(child: CircularProgressIndicator())
          : Background(
              child: RefreshIndicator(
                onRefresh: () async {
                  await getDoctorData();
                  setState(() {});
                },
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 160),
                  itemCount: allEdecatorCourse?.length,
                  itemBuilder: (context, index) {

                    addedAlreadyCoursesOfED.add(
                      (allEdecatorCourse?[index]['Course_ID'])
                      ); 
        print("///////////////////////addedAlreadyCourses\\\\\\\\\\\\\\\\\\\\\\");
        print("${addedAlreadyCoursesOfED}");
        print("///////////////////////addedAlreadyCourses\\\\\\\\\\\\\\\\\\\\\\");     

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
                                    deleteCoure(
                                        allEdecatorCourse?[index]['Course_ID']);

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
                                  'assets/images/addcotoedecatour.jpg',
                                  height: 80,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${allEdecatorCourse?[index]['Course_Name']}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Level ${allEdecatorCourse?[index]['Level']}",
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

  Future<void> deleteCoure(String stringToRemove) async {
    try {
      // FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch the document
      DocumentSnapshot docSnapshot = await doctorDoc!.get();

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
      await doctorDoc?.update({
        'courses': newArray,
      });

      print('String removed successfully!');
    } catch (error) {
      print('Error removing string: $error');
    }
  }
}
