
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/layout/admin_layout.dart';
import 'package:sa7a7/models/Screens/Welcome/welcome_screen.dart';
import 'package:sa7a7/models/shared/componantes/back_ground2.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';

class Login_Screen extends StatefulWidget {
  Login_Screen.LoginScreen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login_Screen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var FormKey = GlobalKey<FormState>();

  bool isPasswoed = true;
  String? user;
  String? user_system;

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
                            builder: (context) => WelcomeScreen()));
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.black,
                  ),
                )),
            backgroundColor: Colors.transparent,
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: FormKey,
                  child: Column(
                    children: [
                      Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
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
                      SizedBox(
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
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                          width: double.infinity,
                          background: Color(0xffF8DEFF),
                          onPressedFunction: () async {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text);
                                      if (user == "Admin") {
                              if (passwordController.text != null) {
                                if (emailController.text != null) {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminHomePage()));
                                  });
                                }
                              }
                            }

                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('----->No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('---->Wrong password provided for that user.');
                              }
                            }

                            // if (FormKey.currentState!.validate()) {
                            //   print(emailController.text);
                            //   print(passwordController.text);
                            // }
                            
                          },
                          text: 'login'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t Have An account ?',
                          ),
                          SizedBox(
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
                            child: Text(
                              'Register',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
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
                              title: Text(
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
