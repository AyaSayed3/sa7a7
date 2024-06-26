import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sa7a7/views/adminScreen/all_cources_page/update_course.dart';
import 'package:sa7a7/views/adminScreen/all_edecatour/view_edecatour_course.dart';

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
  List<QueryDocumentSnapshot<Object?>> allCouresNotAddedToEd=[];
  @override
  void initState() {
    super.initState();
    getDoctorData(docId: widget.docId);
    getData(context: context).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
     allCouresNotAddedToEd=dataCourses;

    for(int index=0;index<allCouresNotAddedToEd.length;index++){
      if(addedAlreadyCoursesOfED.contains(allCouresNotAddedToEd[index]['Course_ID'])){
        allCouresNotAddedToEd.removeAt(index);
         index--;
    }
    }
    return Scaffold(
    appBar: AppBar(title: const Text('Add Course',style: TextStyle(color: Colors.black),),),
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
                         dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'Add Course',
                          desc:
                              ' Are you Sure About Adding this Course with \n level ${dataCourses[index]['Level']} ? ',
                          btnCancelOnPress: () {},
                          btnOkText: 'Add',
                          btnOkOnPress: () {
                            addCoure(
                                    dataCourses[index]['Course_ID'].toString(),
                                    dataCourses[index]['Course_Name'].toString(),
                                    dataCourses[index]['Level'].toString(),
                                    )
                                .then((value) {});
                            Navigator.pop(
                              context,
                            );
                          },
                        ).show();
                      },
                      onLongPress: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: 'Worning',
                          desc: ' Choose Whate do you want to do ? ',
                          btnCancelText: 'Delet',
                          btnCancelOnPress: () async {
                            await FirebaseFirestore.instance
                                .collection('Courses')
                                .doc(dataCourses[index].id)
                                .delete();
                            isLoading = true;
                            setState(() {});

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewEdecatourCourse(
                                          edecatourId: widget.docId,
                                        )));
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
                                'assets/images/addcotoedecatour.jpg',
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

  DocumentReference? doctorDoc;
  Future<void> getDoctorData({required String docId}) async {
    try {
      doctorDoc =
          await FirebaseFirestore.instance.collection('Edecatour').doc(docId);
      doctorDoc?.get();
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> addCoure(
    String coursesId,
    String courseName,
    String courseLevel
  ) async {
    try {
  
      DocumentSnapshot docSnapshot = await doctorDoc!.get();

      if (!docSnapshot.exists) {
        print('Document does not exist!');
        return;
      }

      Map<String, dynamic>? doctorData =
          docSnapshot.data() as Map<String, dynamic>?;
      // Access the field containing the array (replace 'your_array_field' with actual field name)
      List<dynamic> existingArray = doctorData?['courses'] as List<dynamic>;

      // add the string (consider efficiency for large arrays)
      existingArray.add({
        'Course_ID': coursesId,
        'Course_Name': courseName,
        'Level': courseLevel
      });

      // Update the document with the modified array
      await doctorDoc?.update({
        'courses': existingArray,
      });

      print('String add successfully!');
    } catch (error) {
      print('Error add string: $error');
    }
  }
}
