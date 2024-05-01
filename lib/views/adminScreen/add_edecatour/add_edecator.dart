import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sa7a7/views/adminScreen/amdin_layout/admin_layout.dart';

class AddCourseToEdecatourScreen extends StatefulWidget {
  const AddCourseToEdecatourScreen({
    super.key,
  });

  @override
  State<AddCourseToEdecatourScreen> createState() => _AddCourseToEdecatourScreenState();
}

class _AddCourseToEdecatourScreenState extends State<AddCourseToEdecatourScreen> {

 

  

  @override
  void initState() {
    super.initState();
    getEdecatourData(context: context).then((value) {
       setState(() {
      
    });
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingTOedecatour
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
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
                            'assets/images/files.png',
                            height: 100,
                          ),
                          const SizedBox(height: 10),
                          Text("${edecatourData[index]['Adecatour_Name']}",
                          overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

}
