import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:to_do_app/Screens/TaskScreen.dart';
import 'package:to_do_app/Screens/loginScreen.dart';
import 'package:to_do_app/constants.dart';

import 'package:to_do_app/models/DataFirebase.dart';
import 'package:to_do_app/Widgets/CustomButtonWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static String registrationScreenID = 'RegistationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _email;
  String _password;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseController>(
      builder: (context, firebase, child) {
        return Scaffold(
          backgroundColor: Color(0xff222831),
          resizeToAvoidBottomInset: false,
          body: ModalProgressHUD(
            inAsyncCall: _isLoading,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Join us',
                      style: TextStyle(
                        fontSize: 45,
                        color: Color(0xffEEEEEE),
                        fontFamily: 'Nunito',
                      ),
                    ),
                    Text(
                      'Register now',
                      style: TextStyle(
                        fontSize: 45,
                        color: Color(0xffEEEEEE),
                        fontFamily: 'Nunito',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Opacity(
                      opacity: 0.7,
                      child: TextField(
                        style: TextStyle(
                          color: Color(0xff162447),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                        decoration: kLogin_registerTextFields.copyWith(
                            hintText: 'Email'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Opacity(
                      opacity: 0.7,
                      child: TextField(
                        style: TextStyle(
                          color: Color(0xff162447),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        decoration: kLogin_registerTextFields.copyWith(
                            hintText: 'Password'),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                        backgroundColor: Color(0xffff6363),
                        onTap: () async {
                          try {
                            setState(() {
                              _isLoading = true;
                            });
                            String registrationStatus = await firebase
                                .registerWithEmail(_email, _password);
                            setState(() {
                              _isLoading = false;
                            });
                            if (registrationStatus == kSuccessRegistration) {
                              await showOkAlertDialog(
                                context: context,
                                title: 'Check your email',
                                message:
                                    'Hurry up log into your email and verify your account 🏃️, once you verify your account click on Ok ',
                                okLabel: 'Continue',
                                barrierDismissible: false,
                              );
                            }
                            await firebase.auth.currentUser.reload();

                            if (firebase.auth.currentUser.emailVerified) {
                              firebase.createNewUserDocument();

                              Navigator.pushReplacementNamed(
                                  context, TasksScreen.taskScreenId);
                            } else {
                              showModalActionSheet(
                                context: context,
                                title: 'Error',
                                message: 'Failed to verify account 😥️',
                              );
                              await firebase.auth.currentUser.delete();
                            }
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              _isLoading = false;
                            });
                            print(e.code);
                            if (e.code == 'email-already-in-use') {
                              await showAlertDialog(
                                context: context,
                                title: 'You already have an account',
                                message:
                                    'You are going to be directed to the login screen',
                              );
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.loginScreenId);
                            }
                          }
                        },
                        name: 'Register'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
