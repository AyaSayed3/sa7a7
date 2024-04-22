import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa7a7/layout/amdin_layout/cubit/cubit.dart';
import 'package:sa7a7/models/Screens/Login/logen.dart';
import 'package:sa7a7/models/Screens/Welcome/welcome_screen.dart';
import 'package:sa7a7/models/register/register_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}




































































































































































class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     print('-------------------->User is currently signed out!');
    //   } else {
    //     print('--------------------->User is signed in!');
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xffB1699A),
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark),
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        /*home: HomeScreen(),*/
        home: const WelcomeScreen(),
        routes: {'signup': (context) => myRegister(),
         'login':(context) => Login_Screen.LoginScreen(),
         'homepage':(context) => WelcomeScreen(),

        //  /lkolko
         },
      ),
    );
  }
}




