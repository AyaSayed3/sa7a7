import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sa7a7/models/shared/componantes/constents.dart';

class AllCoursesPage extends StatelessWidget {
  AllCoursesPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    // return  Back_ground(
    //   child: Column(
    //     children: [
    //       Text(
    //         'All Courses',
    //         style: TextStyle(
    //           fontSize: 30,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       //  Spacer(
    //       //    flex: 1,
    //       //  ),
       return  ListView.separated(
              
              itemBuilder:(context,index) => buildCourseItem(courses[index]), 
              separatorBuilder: (context,index)=>Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10
                ),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
               itemCount: courses.length,
       );
    //    ],
    //   ),
    // );
  }
}
