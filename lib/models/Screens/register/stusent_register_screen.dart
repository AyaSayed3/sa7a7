import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa7a7/models/Screens/register/before_register.dart';
import 'package:sa7a7/models/Screens/register/resetpass.dart';
import 'package:sa7a7/models/Screens/verification.dart/verifiction_email.dart';
import 'package:sa7a7/models/shared/background.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';

class StudentRegisterScreen extends StatefulWidget {
  const StudentRegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StudentRegisterScreenState createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {

  CollectionReference students = FirebaseFirestore.instance.collection('Students');
    Future<void> addStudentMember() {
     
      return students
          .add({
            'Student_Name': nameController.text, 
            'Student_ID': idController.text, 
            'Email': emailController.text ,
            'Status': 'Student',
            'Passward': passwordController.text,
            'Student_Level': levelController.text,
            'Uniq_ID' : FirebaseAuth.instance.currentUser!.uid,
          })
          .then((value) => print("/////////////Student member Added"))
          .catchError((error) => print("========Failed to add Student member: $error"));
    }


  //Password Field obscureText  Handler

 
  GlobalKey<FormState> adminFormKey = GlobalKey<FormState>();

  bool isPasswoed = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Background(
      child:  SafeArea(
        child:isLoading? const Center(child: CircularProgressIndicator()) : Scaffold(
          appBar: AppBar(
              elevation: null,
              backgroundColor: Colors.transparent,
              leading: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChooseStutesOfMemberBeforRegister()));
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
                        ' Student Register ',
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
                        return null;
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
                        return null;
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
                        return null;
                      },
                    ),
                    
                     const SizedBox(height: 30),
                     defaultTextFromFiled(
                      controller: levelController,
                      label: ' Enter Your Level',
                      keyboardType: TextInputType.number,
                      prefix: Icons.school_rounded,
                      vlidator: (value) {
                        if (value.isEmpty) return 'Student Level Must not Empty';
                        return null;
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
                              if (adminFormKey.currentState!.validate()) {
                                      if (int.parse(idController.text)<300) {
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
                                                    const ChooseStutesOfMemberBeforRegister())));
                                                    
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
                                                addStudentMember();
                                                 clearMethodofStudentRegister();
                                          });
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


