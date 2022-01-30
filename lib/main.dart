import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:chat_app/screens/singnin_screen.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'MessageMe App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialRoute:
        email == null ? WelcomeScreen.screenRoute : ChatScreen.screenRoute,
    routes: {
      WelcomeScreen.screenRoute: (context) => WelcomeScreen(),
      SingninScreen.screenRoute: (context) => SingninScreen(),
      RegistrationScreen.screenRoute: (context) => RegistrationScreen(),
      ChatScreen.screenRoute: (context) => ChatScreen(),
    },
  ) // Wrap your app
      );
}
