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
  List<QueryDocumentSnapshot> edecatourData = [];

  Future<void> getEdecatourData({required BuildContext context}) async {
    edecatourData = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Edecatour')
        .doc(widget.EdecatourId)
        .collection('Course')
        .get();

    edecatourData.addAll(querySnapshot.docs);
    isLoadingECV = false;
  }

  @override
  void initState() {
    super.initState();
    getEdecatourData(context: context).then((value) {
      setState(() {});
    });
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
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 160),
                itemCount: edecatourData.length,
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
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
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
