import 'package:flutter/material.dart';
import 'package:firebase_test/navigator_pages/signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_test/style_elements/input_field.dart';
import 'package:firebase_test/navigator_pages/navigator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_test/navigator_pages/signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_test/style_elements/input_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:http/http.dart';
import 'package:firebase_test/navigator_pages/home_page.dart';
import '../navigator_pages/login_page.dart';

bool global_check = false;

class MyDesktopBody extends StatefulWidget {
  MyDesktopBody({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  static FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  State<MyDesktopBody> createState() => _MyDesktopBodyState();
}

class _MyDesktopBodyState extends State<MyDesktopBody> {
  final ref = MyDesktopBody.database.ref();

  Future<bool> _database() async {
    final snapshot = await ref.child('users/').get();
    if (snapshot.exists) {
      bool isBreak = false;
      for (var m in snapshot.children) {
        bool emailcheck = false;
        bool password = false;
        if (m.child("email").value == userLogin.email) {
          emailcheck = true;
          userLogin.name = m.child("name").value.toString();
          userLogin.userID = m.key.toString();
        }
        if (m.child("password").value == userLogin.password) {
          password = true;
        }
        if (emailcheck && password) {
          isBreak = true;

          if (tempCartExists) {
            FirebaseDatabase database = FirebaseDatabase.instance;
            final ref = database.ref();
            final snapshot = await ref.child('users').get();

            for (var k in (snapshot
                .child("tempUser")
                .child('cart_gameIDs')
                .children)) {
              ref
                  .child('users')
                  .child(userLogin.userID.toString())
                  .child('cart_gameIDs')
                  .child(k.key.toString())
                  .child("amount")
                  .set(k.child("amount").value);
              ref
                  .child('users')
                  .child(userLogin.userID.toString())
                  .child('cart_gameIDs')
                  .child(k.key.toString())
                  .child("name")
                  .set(k.child("name").value);

              ref
                  .child('users')
                  .child(userLogin.userID.toString())
                  .child('cart_gameIDs')
                  .child(k.key.toString())
                  .child("price")
                  .set(k.child("price").value);
            }
            ref.child('users').child("tempUser").remove();

            tempNavigation = false;
          }
        }
      }
      return isBreak;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          color: Color.fromARGB(255, 113, 65, 148),
          child: Row(
            children: [
              // First Column
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text.rich(
                      TextSpan(
                        text: "Welcome to G2B",
                        style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    RoundedInputField(
                      hintText: "Your Email",
                      onChanged: (value) {
                        userLogin.email = value;
                      },
                    ),
                    PasswordField(
                      hintText: "Your Password",
                      onChanged: (value) {
                        userLogin.password = value;
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        _database().then((global_check) {
                          print(global_check);
                          if (global_check) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainNavigator()),
                            );
                          }
                          ;
                        });
                        /*if(global_check){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainNavigator()),
                      );
                    };*/
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text.rich(
                      TextSpan(
                          text: "Don't have an account?",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {
                                  print("Don't have an account?"),
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPageMain()),
                                  )
                                }),
                    ),
                    SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                          text: "Continue without logging in",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {
                                  print("Continue without logging in"),
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainNavigator()),
                                  )
                                }),
                    ),
                  ],
                ),
              ),
              // Second Column
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text.rich(
                      TextSpan(
                        text: "By gamers, for gamers 🚀",
                        style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text.rich(
                      TextSpan(
                        text:
                            "G2B makes games and gaming available for everyone 🙌",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                    SizedBox(height: size.height * 0.025),
                    Text.rich(
                      TextSpan(
                        text: "You can always find a game for yourself",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                    SizedBox(height: size.height * 0.004),
                    Text.rich(
                      TextSpan(
                        text: "from our diverse product library",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                    SizedBox(height: size.height * 0.025),
                    Text.rich(
                      TextSpan(
                        text: "Sign-Up in minutes!",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
