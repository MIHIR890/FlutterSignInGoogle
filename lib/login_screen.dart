import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  Future<void> checkIfLoggedIn(BuildContext context) async {
    // Check if the user is already signed in
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Navigate to HomeScreen if the user is logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            userData: {
              'user': {
                'uid': user.uid,
                'email': user.email,
                'displayName': user.displayName,
                'photoURL': user.photoURL,
              },
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    checkIfLoggedIn(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await _authService.signInWithGoogle();

            if (result['success']) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    userData: result['data']['user'], // Pass user data
                  ),
                ),
              );
            } else {
              print("${result['message']}");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result['message'])),
              );
            }
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}
