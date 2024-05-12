import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/views/adminScreen/all_edecatour/add_coureto_edecator.dart';
import 'package:sa7a7/views/adminScreen/amdin_layout/admin_layout.dart';

class ViewEdecatourCourse extends StatefulWidget {
  final String EdecatourId;
  const ViewEdecatourCourse({
    super.key,
    required this.EdecatourId,
  });

  @override
  State<ViewEdecatourCourse> createState() => _ViewEdecatourCourseState();
}

class _ViewEdecatourCourseState extends State<ViewEdecatourCourse> {
  //List<QueryDocumentSnapshot> edecatourData = [];

DocumentReference? doctorDoc ;
Future<void> getDoctorData() async {
  print(widget.EdecatourId);
  try {
  // Map<String, dynamic> doctorData= 
 doctorDoc = await FirebaseFirestore.instance.collection('Edecatour').doc(widget.EdecatourId);
  doctorDoc?.get().then((value) async {
      // print(value.data() );
      Map<String, dynamic>? doctorData= value.data() as Map<String, dynamic>?;
      // print(doctorData );
      print(doctorData?['courses'] );
      fetchDataAndCheckField(coursesId: doctorData?['courses'] as List<dynamic>  );
  }) ;
   
}   catch (e) {
  isLoadingECV =false;
      setState(() {
        
      });
}
}

  @override
  void initState()  {
   getDoctorData();
    super.initState();
  
  }

  bool isLoadingECV = true;
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
                      docId: widget.EdecatourId,
                    )),
          );
        },
        child: Icon(
          Icons.bookmark_added_sharp,
          size: 35,
        ),
      ),
      body: isLoadingECV
          ? const Center(child: CircularProgressIndicator())
          : Background(
            child: RefreshIndicator(
              onRefresh: () async {
              await  getDoctorData();
              },
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 160),
                  itemCount: Courses?.length ??0,
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
                                    //     .doc(Courses?[index]['Uniq_ID'])
                                    //     .delete();
                                    deleteCoure(Courses?[index]['Course_ID']);
                                       
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
                                const SizedBox(height: 10),
                                Text(
                                  "${Courses?[index]['Course_Name']}",
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

List<Map<String , dynamic>>? Courses =[] ;
Future<void> fetchDataAndCheckField({required List<dynamic> coursesId}) async {
  print("hello bobnaya");
  Courses =[] ;
  try {
    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Efficient filtering query (if applicable)
    Query query = firestore.collection('Courses').where('Course_ID', whereIn: coursesId);
    QuerySnapshot querySnapshot = await query.get();
     
    querySnapshot.docs.forEach((e) {
      print(e.data());
      Map<String, dynamic>  temp = e.data() as Map<String, dynamic> ;
      Courses?.add( temp);

    });
   
    setState(() {
      isLoadingECV = false;
    });
  } catch (error) {
    // Handle specific errors (e.g., FirebaseException)
    print('Error fetching data: $error');
    
  } finally {
    // Perform cleanup tasks if necessary (e.g., indicating loading completion)
    isLoadingECV = false; // Assuming this flag is used for loading state
    setState(() {
      // Update loading state if relevant
    });
  }

  return; // Explicitly return to match function signature
}

Future<void> deleteCoure( String stringToRemove) async {
  try {
    // FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Fetch the document
    DocumentSnapshot docSnapshot = await doctorDoc!.get();

    if (!docSnapshot.exists) {
      print('Document does not exist!');
      return;
    }

    Map<String, dynamic>? doctorData= docSnapshot.data() as Map<String, dynamic>?;
    // Access the field containing the array (replace 'your_array_field' with actual field name)
    List<dynamic> existingArray = doctorData?['courses'] as List<dynamic>;

    // Remove the string (consider efficiency for large arrays)
    List<dynamic> newArray=[];
      existingArray.forEach((element) {
      print("<<<<<<<<<<<<$element>>>>>>>>>>>>>");

        if (element != stringToRemove){
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


