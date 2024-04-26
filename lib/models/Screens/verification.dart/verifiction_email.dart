import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/Screens/Login/logen.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';

class VerifictionEmail extends StatefulWidget {
  const VerifictionEmail({super.key});

  @override
  State<VerifictionEmail> createState() => _VerifictionEmailState();
}

class _VerifictionEmailState extends State<VerifictionEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  const Text(
                    'Verification Email',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Please Check your Email we Send Verification e-mail ',
                    style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                  ),
                  // don't view the email
                  Text(
                    emailController.text,
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'If you didn’t receive a code?',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.currentUser!
                                .sendEmailVerification();
                          },
                          child: const Text('Resend'))
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            defaultButton(
                onPressedFunction: () {
                   FirebaseAuth.instance.currentUser!
                                .sendEmailVerification();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const LoginScreen()));
                },
                text: 'Continue'),
          ],
        ),
      ),
    );
  }
}
