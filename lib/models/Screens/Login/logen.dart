// ignore_for_file: non_constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/Screens/Welcome/welcome_screen.dart';
import 'package:sa7a7/models/Screens/register/before_register.dart';
import 'package:sa7a7/models/Screens/register/resetpass.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';
import 'package:sa7a7/views/adminScreen/amdin_layout/admin_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  bool isPasswoed = true;
  bool isLoading = false;
  // bool isAdmin = false;
  // bool isEdecatour = false;
  // bool isStudent = false;

  String? user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Background(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
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
                ),
              ),
              backgroundColor: Colors.transparent,
              body: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/Correx.jpg',
                                height: 100,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              defaultTextFromFiled(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                label: 'Email address',
                                prefix: Icons.email,
                                vlidator: (value) {
                                  if (value.isEmpty) {
                                    return ' email must be nit empty';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              defaultTextFromFiled(
                                controller: passwordController,
                                label: 'Password',
                                keyboardType: TextInputType.visiblePassword,
                                prefix: Icons.lock,
                                vlidator: (value) {
                                  if (value.isEmpty) {
                                    return ' password must be nit empty';
                                  }
                                  return null;
                                },
                                ispasswoard: isPasswoed,
                                sufix: isPasswoed
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                sufixFunction: () {
                                  setState(() {
                                    isPasswoed = !isPasswoed;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              defaultButton(
                                  width: double.infinity,
                                  background: const Color(0xffF8DEFF),
                                  onPressedFunction: () async {
                                    if (formKey.currentState!.validate()) {
                                      isLoading = true;
                                      try {
                                        setState(() {});
                                              // ignore: unused_local_variable
                                        final credential =
                                            await FirebaseAuth.instance
                                                .signInWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        )
                                                .then((value) {
                                          isLoading = false;
                                          setState(() {});
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminHomePage()),
                                          ).then((value) {
                                            isLoading = false;
                                            print(
                                                '<<<<<<<<<<<<<<<<<<<<2>>>>>>>>>>>>>>>>>>>>>');
                                            setState(() {});
                                          });
                                        });
                                      } on FirebaseAuthException catch (e) {
                                        isLoading = false;
                                        setState(() {});
                                        print(e);

                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.error,
                                          animType: AnimType.rightSlide,
                                          title: 'Error',
                                          desc: 'email or Password wong',
                                        ).show();
                                      }
                                    }
                                  },
                                  text: 'login'),
                              const SizedBox(height: 30),
                              defaultButton(
                                  onPressedFunction: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ResetPassword()));
                                  },
                                  text: 'Forget Password'),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t Have An account ?',
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ChooseStutesOfMemberBeforRegister()));
                                    },
                                    child: const Text(
                                      'Register',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: RadioListTile(
                              //         visualDensity: VisualDensity.comfortable,
                              //         title: const Text(
                              //           "Admin",
                              //           style: TextStyle(fontSize: 16),
                              //         ),
                              //         value: "Admin",
                              //         groupValue: user,
                              //         onChanged: (value) {
                              //           setState(() {
                              //             user = value.toString();
                              //             print(
                              //                 '>>>>>>>>>> $user <<<<<<<<<<<<');
                              //           });
                              //         },
                              //         dense: true,
                              //       ),
                              //     ),
                              //     Expanded(
                              //       child: RadioListTile(
                              //         title: const Text(
                              //           "Edecatour",
                              //           style: TextStyle(fontSize: 15),
                              //         ),
                              //         value: "Edecatour",
                              //         groupValue: user,
                              //         onChanged: (value) {
                              //           setState(() {
                              //             user = value.toString();
                              //             print(
                              //                 '>>>>>>>>>> $user <<<<<<<<<<<<');
                              //           });
                              //         },
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // RadioListTile(
                              //   title: const Text("Student",
                              //       style: TextStyle(fontSize: 18)),
                              //   value: "Student",
                              //   groupValue: user,
                              //   onChanged: (value) {
                              //     setState(() {
                              //       user = value.toString();
                              //       print('>>>>>>>>>> $user <<<<<<<<<<<<');
                              //     });
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }


}
