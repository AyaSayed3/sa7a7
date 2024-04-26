import 'package:flutter/material.dart';
import 'package:sa7a7/models/Screens/Welcome/copmonents/background.dart';
import 'package:sa7a7/models/Screens/Welcome/copmonents/login_signup_btn.dart';
import 'package:sa7a7/models/responsive.dart';

import 'copmonents/welcome_image.dart';



class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return const BackGroundWelcom(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: WelcomeImage(),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 450,
                        child: LoginAndSignupBtn(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            mobile: MobileWelcomeScreen(),
          ),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        WelcomeImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginAndSignupBtn(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
