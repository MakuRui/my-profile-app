import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_profile_app/pages/auth_page.dart';
import 'package:my_profile_app/pages/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'),);
          } else if (snapshot.hasData) {
            return const ProfilePage();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
