import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sa7a7/views/adminScreen/all_cources_page/update_course.dart';
import 'package:sa7a7/views/adminScreen/all_student/view_student_course.dart';

class AddCourseToStudent extends StatefulWidget {
  final String studentId;
  const AddCourseToStudent({
    super.key,
    required this.studentId,
  });

  @override
  State<AddCourseToStudent> createState() => _AddCourseToStudentState();
}

class _AddCourseToStudentState extends State<AddCourseToStudent> {
  @override
  void initState() {
  
     getStudentData(stuId: widget.studentId);
    getData(context: context).then((value) {
      setState(() {});
    });
      super.initState();
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
                          desc: ' Are you Sure About Adding this Course with \n level ${dataCourses[index]['Level']} ? ',
            
                          btnCancelOnPress: ()  {
                          
                          },
                          btnOkText: 'Add',
                          btnOkOnPress: () {
                           addCoure(dataCourses[index]['Course_ID'].toString() ).then((value) {

                                
                              });
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
                                    builder: (context) =>  ViewStudentCourse(studentId: widget.studentId , )));
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
                                    " Level ${dataCourses[index]['Level']}",
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
DocumentReference? studentDoc ;
Future<void> getStudentData({required String stuId}) async {
  
  try {
  
 studentDoc = await FirebaseFirestore.instance.collection('Students').doc(stuId);
  studentDoc?.get();
   
}   catch (e) {
  
      setState(() {
        
      });
}
}

Future<void> addCoure( String coursesId) async {
  try {
    // FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Fetch the document
    DocumentSnapshot docSnapshot = await studentDoc!.get();

    if (!docSnapshot.exists) {
      print('Document does not exist!');
      return;
    }

    Map<String, dynamic>? doctorData= docSnapshot.data() as Map<String, dynamic>?;
    // Access the field containing the array (replace 'your_array_field' with actual field name)
    List<dynamic> existingArray = doctorData?['courses'] as List<dynamic>;

    // add the string (consider efficiency for large arrays)
    existingArray.add(coursesId);

    // Update the document with the modified array
    await studentDoc?.update({
      'courses': existingArray,
    });

    print('String add successfully!');
  } catch (error) {
    print('Error add string: $error');
  }
}

}
