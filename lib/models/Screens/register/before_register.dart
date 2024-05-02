import 'package:flutter/material.dart';
import 'package:sa7a7/models/Screens/Welcome/welcome_screen.dart';
import 'package:sa7a7/models/Screens/register/admin_register_screen.dart';
import 'package:sa7a7/models/Screens/register/doctor_register_screen.dart';
import 'package:sa7a7/models/Screens/register/stusent_register_screen.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';

class ChooseStutesOfMemberBeforRegister extends StatelessWidget {
  const ChooseStutesOfMemberBeforRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: null,
            backgroundColor: Colors.transparent,
            leading: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()));
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
            )),
        body: Background(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  maxLines: 2,
                  'Please Choose Stutes Of You Befor Your Register',
                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                defaultButton(
                    height: 50,
                    onPressedFunction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminRegisterScreen()));
                    },
                    text: 'Admin'),
                const SizedBox(height: 40),
                defaultButton(
                    height: 50,
                    onPressedFunction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EdecatourRegisterScreen()));
                    },
                    text: 'Edecatour'),
                const SizedBox(height: 40),
                defaultButton(
                    height: 50,
                    onPressedFunction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const StudentRegisterScreen()));
                    },
                    text: 'Student'),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
