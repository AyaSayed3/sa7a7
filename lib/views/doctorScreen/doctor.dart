import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/background.dart';

class DoctorHomPage extends StatelessWidget {
  const DoctorHomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Background(child: Center(child: Text('Doctor Screen'))),
    );
  }
}