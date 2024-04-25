// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/Screens/Welcome/welcome_screen.dart';
import 'package:sa7a7/models/register/resetpass.dart';
import 'package:sa7a7/models/shared/componantes/back_ground2.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  //Password Field obscureText  Handler

  var emailController = TextEditingController();
  var passwardController = TextEditingController();
  var nameController = TextEditingController();
  var idController = TextEditingController();

  bool isPasswoed = true;
 

  @override
  Widget build(BuildContext context) {
    return Background(
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
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 30),
                    defaultTextFromFiled(
                      controller: nameController,
                      label: ' Enter User Name',
                      keyboardType: TextInputType.name,
                      prefix: Icons.person,
                      vlidator: (value) {
                        if (value.isEmpty()) return 'Name Must not Empty';
                      },
                    ),
                    const SizedBox(height: 30),
                    defaultTextFromFiled(
                      controller: emailController,
                      label: ' Enter Your Email',
                      keyboardType: TextInputType.emailAddress,
                      prefix: Icons.email,
                      vlidator: (value) {
                        if (value.isEmpty()) return 'Email Must not Empty';
                      },
                    ),
                    const SizedBox(height: 30),
                    defaultTextFromFiled(
                      controller: idController,
                      label: ' Enter Your ID',
                      keyboardType: TextInputType.number,
                      prefix: Icons.perm_identity,
                      vlidator: (value) {
                        if (value.isEmpty()) return 'ID Must not Empty';
                      },
                    ),
                    const SizedBox(height: 30),
                    defaultTextFromFiled(
                      controller: passwardController,
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
                      sufix:
                          isPasswoed ? Icons.visibility_off : Icons.visibility,
                      sufixFunction: () {
                        setState(() {
                          isPasswoed = !isPasswoed;
                        });
                      },
                    ),
                    const SizedBox(height: 80),
                    Row(children: [
                      Expanded(
                        child: defaultButton(
                            onPressedFunction: () async {
                              if (formKey.currentState!.validate()) {
                                // FirebaseAuth.instance.currentUser!
                                //     .sendEmailVerification();
                                // try {
                                //   await FirebaseAuth.instance
                                //       .createUserWithEmailAndPassword(
                                //     email: emailController.text,
                                //     password: passwardController.text,
                                //   )
                                //       .then((value) {
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 const VerifictionEmail()));
                                //   });
                                // } on FirebaseAuthException catch (e) {
                                //   if (e.code == 'weak-password') {
                                //     print('The password provided is too weak.');
                                //   } else if (e.code == 'email-already-in-use') {
                                //     print(
                                //         'The account already exists for that email.');
                                //   }
                                // } catch (e) {
                                //   print('@@@@@@@@@@@@@@@@@@@@@  $e');
                                // }

                                
                                // FirebaseAuth.instance.currentUser!
                                //     .sendEmailVerification();
                                // try {
                                //   await FirebaseAuth.instance
                                //       .createUserWithEmailAndPassword(
                                //     email: emailController.text,
                                //     password: passwardController.text,
                                //   )
                                //       .then((value) {
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 const VerifictionEmail()));
                                //   });
                                // } on FirebaseAuthException catch (e) {
                                //   if (e.code == 'weak-password') {
                                //     print('The password provided is too weak.');
                                //   } else if (e.code == 'email-already-in-use') {
                                //     print(
                                //         'The account already exists for that email.');
                                //   }
                                // } catch (e) {
                                //   print('@@@@@@@@@@@@@@@@@@@@@  $e');
                                // }
                              }
                            },
                            text: 'Regster'),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: defaultButton(
                            onPressedFunction: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ResetPassword()));
                            },
                            text: 'Forget Passward'),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



   // children: [
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         'REGISTER\n NOW',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 40.0,
              //         ),
              //       ),
              //     ],
              //   ),
              //   SingleChildScrollView(
              //     child: Container(
              //       padding: EdgeInsets.only(
              //         top: MediaQuery.of(context).size.height * 0.28,
              //         left: 35,
              //         right: 35,
              //       ),
              //       child: Column(
              //         children: [
              //           TextField(
              //             decoration: InputDecoration(
              //               labelText: 'Username',
              //               fillColor: Colors.transparent,
              //               filled: true,
              //               border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(10.0),
              //                   borderSide: const BorderSide(
              //                     color: Colors.white,
              //                   )),
              //             ),
              //           ),
              //           SizedBox(height: 30.0),
              //           TextField(
              //             decoration: InputDecoration(
              //               fillColor: Colors.transparent,
              //               prefixIcon: Icon(Icons.email_outlined),
              //               filled: true,
              //               labelText: 'Email',
              //               border: OutlineInputBorder(
              //                 borderRadius: BorderRadius.circular(10.0),
              //                 borderSide: BorderSide(
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ),
              //           ),
              //           SizedBox(height: 30.0),
              //           TextField(
              //             decoration: InputDecoration(
              //               fillColor: Colors.transparent,
              //               prefixIcon: Icon(Icons.phone),
              //               filled: true,
              //               labelText: 'Phone',
              //               border: OutlineInputBorder(
              //                 borderRadius: BorderRadius.circular(10.0),
              //                 borderSide: const BorderSide(
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ),
              //           ),
              //           SizedBox(height: 30.0),
              //           TextField(
              //             obscureText: _isHidden,
              //             decoration: InputDecoration(
              //               fillColor: Colors.transparent,
              //               prefixIcon: Icon(Icons.lock),
              //               suffixIcon: IconButton(
              //                 onPressed: _toggleVisibility,
              //                 icon: _isHidden
              //                     ? Icon(Icons.visibility)
              //                     : Icon(Icons.visibility_off),
              //               ),
              //               filled: true,
              //               labelText: 'Password',
              //               border: OutlineInputBorder(
              //                 borderRadius: BorderRadius.circular(10.0),
              //                 borderSide: const BorderSide(
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ),
              //           ),
              //           SizedBox(height: 30.0),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.end,
              //             children: [
              //               ElevatedButton(
              //                   style: ElevatedButton.styleFrom(
              //                     maximumSize: const Size(170.0, 90.0),
              //                      backgroundColor: Color(0xffF8DEFF),
              //                     minimumSize: const Size(170.0, 60.0),
              //                     shape: const StadiumBorder(),
              //                   ),
              //                   onPressed: () {},
              //                   child: const Row(
              //                     mainAxisAlignment:
              //                     MainAxisAlignment.spaceBetween,
              //                     //crossAxisAlignment: CrossAxisAlignment.center,
              //                     children: [
              //                       Text('REGISTER',
              //                       style: TextStyle(color: Colors.black),),
              //                       Icon(
              //                         Icons.content_paste_rounded,
              //                         color: Colors.black87,
              //                       ),
              //                     ],
              //                   )),
              //             ],
              //           ),
              //           SizedBox(height: 30.0),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               TextButton(
              //                 onPressed: () {
              //                   Navigator.push(
              //                       context,
              //                       MaterialPageRoute(
              //                           builder: (context)=>  Login_Screen.LoginScreen())
              //                   );
              //                 },
              //                 child: Text(
              //                   'Login',
              //                   style: TextStyle(color: Colors.black),
              //                 ),
              //               ),
              //               TextButton(
              //                 onPressed: () {
              //                   Navigator.push(
              //                       context,
              //                       MaterialPageRoute(
              //                           builder: (context)=>  resetPassword())
              //                   );
              //                 },
              //                 child: Text(
              //                   'Forgot password?',
              //                   style: TextStyle(color: Colors.black),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ],
              