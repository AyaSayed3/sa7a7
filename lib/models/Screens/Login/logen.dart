import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/layout/admin_layout.dart';
import 'package:sa7a7/models/Screens/Welcome/welcome_screen.dart';
import 'package:sa7a7/models/shared/componantes/back_ground2.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen.LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  var formKey = GlobalKey<FormState>();

  bool isPasswoed = true;
  String? user;
  String? usersystem;

  @override
  Widget build(BuildContext context) {
    return Background(
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
                )),
            backgroundColor: Colors.transparent,
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 40.0,
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
                            if(formKey.currentState!.validate()){
                                try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              print(credential.user!.email);
                              print(credential.user!.uid);
                              if (user == "Admin") {
                                if (credential.user?.uid != null) {
                                  if (passwordController.text != '') {
                                    if (emailController.text != '') {
                                      setState(() {
                                      if (credential.user!.emailVerified)
                                      {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminHomePage()));
                                      }else {
                                         AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: '----->Please Check your Email we Send Verification e-mail......',
                                
                                ).show();
                                      }
                                      });
                                    }
                                  }
                                }
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('----->No user found for that email.');

                                //not work 
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: '----->No user found for that email......',
                                
                                ).show();
                              } else if (e.code == 'wrong-password') {
                                print(
                                    '---->Wrong password provided for that user.');
                                      //not work 
                                     AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: '---->Wrong password provided for that user...',
                                
                                ).show();
                              }
                            }
                            }
                          
                          },
                          text: 'login'),
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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context)=> const myRegister())
                              // );
                              Navigator.of(context)
                                  .pushReplacementNamed('signup');
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
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              visualDensity: VisualDensity.comfortable,
                              title: const Text(
                                "Admin",
                                style: TextStyle(fontSize: 18),
                              ),
                              value: "Admin",
                              groupValue: user,
                              onChanged: (value) {
                                setState(() {
                                  user = value.toString();
                                });
                              },
                              dense: true,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: const Text(
                                "Doctor",
                                style: TextStyle(fontSize: 19),
                              ),
                              value: "Doctor",
                              groupValue: user,
                              onChanged: (value) {
                                setState(() {
                                  user = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      RadioListTile(
                        title: const Text("Student",
                            style: TextStyle(fontSize: 18)),
                        value: "Student",
                        groupValue: user,
                        onChanged: (value) {
                          setState(() {
                            user = value.toString();
                          });
                        },
                      )
                    ],
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
