import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';

class Authlogin extends StatefulWidget {
  const Authlogin({super.key});

  @override
  State<Authlogin> createState() => _AuthloginState();
}

class _AuthloginState extends State<Authlogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(
        providers: [
          EmailAuthProvider(),
          GoogleProvider(
            clientId:"307842650757-ud10crl5a9u2poirun8t235657fdf7lg.apps.googleusercontent.com",
          ),
        ],
        showPasswordVisibilityToggle: true,
      ),
    );
  }
}
