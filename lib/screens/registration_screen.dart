import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/mybutton_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  static const String screenRoute = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;
  final _textEmail = TextEditingController();
  final _textPassword = TextEditingController();

  bool _validate = false;
  void showToast(String error) {
    Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 150),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 180,
                  child: Image.asset("images/logo.png"),
                ),
                const SizedBox(
                  height: 35,
                ),
                TextField(
                  controller: _textEmail,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (val) {
                    email = val;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    errorText: _validate ? 'Email Can\'t Be Empty' : null,
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide:
                          BorderSide(color: Colors.amberAccent, width: 1.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    hintText: 'Enter your email',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _textPassword,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  onChanged: (val) {
                    password = val;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    errorText: _validate ? 'Password Can\'t Be Empty' : null,
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide:
                          BorderSide(color: Colors.amberAccent, width: 1.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    hintText: 'Enter your password',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  title: "Log in",
                  color: Colors.blue[700]!,
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {
                      _textEmail.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                    });
                    if (_validate == false) {
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);

                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        prefs.setString('email', email);
                        Navigator.pushNamed(context, ChatScreen.screenRoute);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showToast("The password provided is too weak.");
                        } else if (e.code == 'email-already-in-use') {
                          showToast(
                              "The account already exists for that email.");
                        }
                      } catch (e) {
                        showToast(e.toString());
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
