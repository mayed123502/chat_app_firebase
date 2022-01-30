import 'package:chat_app/widgets/mybutton_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'registration_screen.dart';
import 'singnin_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute  = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child: Image.asset("images/logo.png"),
                ),
                const Text(
                  "MessageMe",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff2e386b)),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            MyButton(
              color: Colors.yellow[900]!,
              title: "Sign in ",
              onPressed: () {
                Navigator.pushNamed(context, SingninScreen.screenRoute);
              },
            ),
            MyButton(
              color: Colors.blue[900]!,
              title: "Register ",
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.screenRoute);

              },
            ),
          ],
        ),
      ),
    );
  }
}

// Colors.yellow[900]
