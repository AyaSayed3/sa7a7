import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/Screens/register/before_register.dart';
import 'package:sa7a7/models/Screens/register/resetpass.dart';
import 'package:sa7a7/models/Screens/verification.dart/verifiction_email.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';

class AdminRegisterScreen extends StatefulWidget {
  const AdminRegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminRegisterScreenState createState() => _AdminRegisterScreenState();
}

class _AdminRegisterScreenState extends State<AdminRegisterScreen> {
  CollectionReference admins = FirebaseFirestore.instance.collection('Admins');
    Future<void> addAmdinMember() {
     
      return admins
          .add({
            'Admin_Name': nameController.text, 
            'Admin_ID': idController.text, 
            'Email': emailController.text ,
            'Status': 'admin',
            'Passward': passwordController.text,
            // 'Uniq_ID' : FirebaseAuth.instance.currentUser!.uid,
          })
          .then((value) => print("Admin member Added"))
          .catchError((error) => print("Failed to add Amin member: $error"));
    }





  //Password Field obscureText  Handler

  GlobalKey<FormState> adminFormKey = GlobalKey<FormState>();

  bool isPasswoed = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: AppBar(
                    elevation: null,
                    backgroundColor: Colors.transparent,
                    leading: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ChooseStutesOfMemberBeforRegister()));
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
                      key: adminFormKey,
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              'Admin Register ',
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
                              if (value.isEmpty) return 'Name Must not Empty';
                            },
                          ),
                          const SizedBox(height: 30),
                          defaultTextFromFiled(
                            controller: emailController,
                            label: ' Enter Your Email',
                            keyboardType: TextInputType.emailAddress,
                            prefix: Icons.email,
                            vlidator: (value) {
                              if (value.isEmpty) return 'Email Must not Empty';
                            },
                          ),
                          const SizedBox(height: 30),
                          defaultTextFromFiled(
                            controller: idController,
                            label: ' Enter Your ID',
                            keyboardType: TextInputType.number,
                            prefix: Icons.perm_identity,
                            vlidator: (value) {
                              if (value.isEmpty) return 'ID Must not Empty';
                            },
                          ),
                          const SizedBox(height: 30),
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
                          const SizedBox(height: 80),
                          Row(children: [
                            Expanded(
                              child: defaultButton(
                                  onPressedFunction: () async {
                                    
                                    if (adminFormKey.currentState!.validate()) {
                                      if (int.parse(idController.text) > 10) {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.warning,
                                          animType: AnimType.rightSlide,
                                          title: 'Warning',
                                          desc:
                                              'Please Choose the correct Stutes',
                                        ).show().then((value) => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ChooseStutesOfMemberBeforRegister())),
                                                     
                                                    );
                                                   
                                      } else {
                                        try {
                                          isLoading = true;
                                          setState(() {});
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          )
                                              .then((value) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const VerifictionEmail()));

                                            FirebaseAuth.instance.currentUser!
                                                .sendEmailVerification();
                                                
                                                // addAmdinMember();
                                                //clearMethodofRegister();
                                          });
                                           addAmdinMember();
                                           clearMethodofRegister();
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'weak-password') {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.error,
                                              animType: AnimType.rightSlide,
                                              title: 'Error',
                                              desc:
                                                  '-->The password provided is too weak...',
                                            ).show();
                                          } else if (e.code ==
                                              'email-already-in-use') {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.error,
                                              animType: AnimType.rightSlide,
                                              title: 'Error',
                                              desc:
                                                  '-->The account already exists for that email....',
                                            ).show();
                                          }
                                           // clearMethodofRegister();
                                        }
                                        // catch (e) {
                                        //   print('@@@@@@@@@@@@@@@@@@@@@  $e');
                                        // }
                                      }
                                      isLoading = false;
                                      setState(() {});
                                  
                                  
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
              