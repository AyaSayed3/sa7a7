import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = const Color(0xffF8DEFF),
  bool isUpperCase = true,
  required void Function()? onPressedFunction,
  required String text,
  double radius = 20.0,
  double height = 40,
}) =>
    Container(
      height: height,
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
var nameController = TextEditingController();
var idController = TextEditingController();
var levelController = TextEditingController();
clearMethodofRegister() {
  emailController.clear();
  passwordController.clear();
  nameController.clear();
  idController.clear();
}

clearMethodofStudentRegister() {
  clearMethodofRegister();
  // levelController.clear();
}

var nameCourseController = TextEditingController();
var idCourseController = TextEditingController();
var levelCourseController = TextEditingController();

clearMethodOfFlotBottom() {
  nameCourseController.clear();
  idCourseController.clear();
  levelCourseController.clear();
}

var formKeyAddCourse = GlobalKey<FormState>();

bool isButtomSheetShown = false;

List<QueryDocumentSnapshot> dataCourses = [];
bool isLoading = true;

Future<void> getData({required BuildContext context}) async {
  dataCourses = [];
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Courses') .where('Uniq_ID', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
  dataCourses.clear();
  dataCourses.addAll(querySnapshot.docs);
  isLoading = false;
  isButtomSheetShown = false;
}
List<QueryDocumentSnapshot> adminData = [];
bool isLoadingTOadmin = true;
Future<void> getAdminData({required BuildContext context}) async {
  adminData = [];
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Admins')
      .get();
  adminData.addAll(querySnapshot.docs);
  isLoadingTOadmin = false;
}
List<QueryDocumentSnapshot> edecatourData = [];
bool isLoadingTOedecatour = true;
Future<void> getEdecatourData({required BuildContext context}) async {
  edecatourData = [];
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('Edecatour').get();
  edecatourData.addAll(querySnapshot.docs);
  isLoadingTOedecatour = false;
}

List<QueryDocumentSnapshot> studentData = [];
bool isLoadingTOstudent = true;
Future<void> getstudentData({required BuildContext context}) async {
  studentData = [];
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('Students').get();
  studentData.addAll(querySnapshot.docs);
  isLoadingTOstudent = false;
}

List <dynamic>? allEdecatorCourse=[];
List <dynamic> allStudentCourse=[];

List<String?> addedAlreadyCourses=[];

List<String?> addedAlreadyCoursesOfED=[];


