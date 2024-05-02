import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/background.dart';

class StudentHomPage extends StatelessWidget {
  const StudentHomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Background(child: Center(child: Text('Student Screen'))),
    );
  }
}