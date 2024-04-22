import 'dart:ffi';

import 'package:flutter/material.dart';

Widget defaultButton(
        {double width = double.infinity,
        Color background = const Color(0xffF8DEFF),
        bool isUpperCase = true,
        required VoidCallback onPressedFunction,
        required String text,
        double radius = 20.0}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: onPressedFunction,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget defaultTextFromFiled({
  required TextEditingController controller,
  Void onSubmitted(String)?,
  Void onChange(String)?,
  String? vlidator(String)?,
  bool ispasswoard = false,
  required String label,
  required TextInputType keyboardType,
  required IconData prefix,
  IconData? sufix,
  Void? sufixFunction()?,
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
        border: OutlineInputBorder( borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(20)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
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

Widget buildCourseItem(Map model) =>  Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        //   children: [
        //      Text( cubit.nameController.text??"test 1",
        //  style: TextStyle(
        //      fontSize: 20,
        //      fontWeight: FontWeight.bold,
        //      color: Colors.black
        //    ),
        //  ),
        //  Spacer(
        //    flex: 1,
        //  ),
        //       Text( cubit.idController.text??"test 2",
        //  style: TextStyle(
        //      fontSize: 20,
        //      fontWeight: FontWeight.bold,
        //      color: Colors.black
        //    ),
        //  ),
        //  Spacer(
        //    flex: 1,
        //  ),
        //       Text( cubit.levelController.text??"test 2",
        //  style: TextStyle(
        //      fontSize: 20,
        //      fontWeight: FontWeight.bold,
        //      color: Colors.black
        //    ),
        //  ),
        //   ],
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              '${model['courseLevel']}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['couseName']}',
                style: TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['courseId']}',
                style: TextStyle(
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
