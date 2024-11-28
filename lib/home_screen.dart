import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  HomeScreen({required this.userData});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (userData['photoURL'] != null)
              CircleAvatar(
                backgroundImage: NetworkImage(userData['photoURL']),
                radius: 50,
              ),
            SizedBox(height: 20),
            Text('Welcome, ${userData['displayName']}'),
            Text('Email: ${userData['email']}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Log out and navigate to LoginScreen
                await _authService.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
