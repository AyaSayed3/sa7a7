import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget defaultButton(
        {double width = double.infinity,
        Color background = const Color(0xffF8DEFF),
        bool isUpperCase = true,
        required void Function()? onPressedFunction,
        required String text,
        double radius = 20.0}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: onPressedFunction,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.black87,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Widget defaultTextFromFiled({
  required TextEditingController controller,
  void onSubmitted(String)?,
  void onChange(String)?,
  String? vlidator(String)?,
  bool ispasswoard = false,
  required String label,
  required TextInputType keyboardType,
  required IconData prefix,
  IconData? sufix,
  void sufixFunction()?,
}) =>
    TextFormField(
      controller: controller,
      onFieldSubmitted: onSubmitted,
      onChanged: onChange,
      validator: vlidator,
      keyboardType: keyboardType,
      obscureText: ispasswoard,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(20)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(20)),
        prefixIcon: Icon(prefix),
        suffixIcon: sufix != null
            ? IconButton(
                onPressed: sufixFunction,
                icon: Icon(sufix),
              )
            : null,
      ),
    );

Widget buildCourseItem(Map model) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              '${model['courseLevel']}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['couseName']}',
                style: const TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['courseId']}',
                style: const TextStyle(
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
var emailController = TextEditingController();

var passwordController = TextEditingController();
 GlobalKey<FormState> formKey = GlobalKey<FormState>();

   

  var nameController = TextEditingController();
  var idController = TextEditingController();
  var levelController = TextEditingController();

  clearMethod(){
    
   nameController.clear();
   idController.clear() ;
   levelController.clear();
  }




  var formKeyAddCourse = GlobalKey<FormState>();

  bool isButtomSheetShown = false;
 
   List <QueryDocumentSnapshot> dataCourse = [];
  bool isLoading = true;
  int count=0;
   Future<void> getData({required BuildContext context}) async {
    count++;
            print("///////////////////////count\\\\\\\\\\\\\\\\\\\\\\");
        print("${count}");
        print("///////////////////////count\\\\\\\\\\\\\\\\\\\\\\");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Courses').get();
    dataCourse.clear();
    dataCourse.addAll(querySnapshot.docs);
    isLoading = false;
    isButtomSheetShown=false;

     print("///////////////////////dataCourse.length\\\\\\\\\\\\\\\\\\\\\\");
        print("${dataCourse.length}");
        print("///////////////////////dataCourse.length\\\\\\\\\\\\\\\\\\\\\\");
    //Navigator.pop(context);
  
    // setState(() {
      
    // });
    

    
  }