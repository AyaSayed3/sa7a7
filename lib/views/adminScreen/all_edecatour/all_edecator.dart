import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sa7a7/views/adminScreen/all_edecatour/view_edecatour_course.dart';
import 'package:sa7a7/views/adminScreen/amdin_layout/admin_layout.dart';

class AllEdecatourScreen extends StatefulWidget {
  const AllEdecatourScreen({
    super.key,
  });

  @override
  State<AllEdecatourScreen> createState() => _AllEdecatourScreenState();
}

class _AllEdecatourScreenState extends State<AllEdecatourScreen> {
  @override
  void initState() {
    super.initState();
    getEdecatourData(context: context).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingTOedecatour
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  ViewEdecatourCourse(EdecatourId: edecatourData[index].id,)));
                    },
                    onLongPress: () {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.rightSlide,
                              title: 'Worning',
                              desc: 'Are You Sure about Dlete this Edecatour..',
                              btnOkOnPress: () async {
                                await FirebaseFirestore.instance
                                    .collection('Edecatour')
                                    .doc(edecatourData[index].id)
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
                              'assets/images/person4.jpg',
                              height: 100,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${edecatourData[index]['Adecatour_Name']}",
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
