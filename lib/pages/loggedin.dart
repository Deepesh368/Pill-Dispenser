// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../provider/google_sign_in.dart';
import 'home.dart';

class LoggedIn extends StatelessWidget {
  static const routeName = '/loggedin';

  const LoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Logged In!'),
        actions: [
          TextButton(
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
              Navigator.popAndPushNamed(context, '/signup');
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Profile Info',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(
              height: 36.0,
            ),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user!.photoURL!),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              'Username: ' + user.displayName!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              'Email: ' + user.email!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 36.0,
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Home.routeName);
              },
              child: const Text('Continue'),
              color: Colors.greenAccent,
            ),
          ],
        ),
      ),
    );
  }
}
