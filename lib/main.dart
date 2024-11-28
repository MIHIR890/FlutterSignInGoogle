import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  LoginScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     clientId: '964988269089-ur331nnlu4bbvkcnmmue6ul8vanmp7l8.apps.googleusercontent.com', // Add your client ID here
//   );
//
//   Future<void> signInWithGoogle() async {
//     try {
//       // Sign in with Google
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         // User canceled the sign-in process
//         return;
//       }
//
//       final GoogleSignInAuthentication googleAuth =
//       await googleUser.authentication;
//
//       // Extract the ID token
//       final idToken = googleAuth.idToken;
//
//       // Send the token to the backend
//       final response = await http.post(
//         Uri.parse('http://192.168.2.174:3000/googleSignIn'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'idToken': idToken}),
//       );
//
//       if (response.statusCode == 200) {
//         // Parse the response
//         final data = jsonDecode(response.body);
//         print('Login Successful: ${data['message']}');
//         print('User Details: ${data['user']}');
//         // Store token locally for secure access
//       } else {
//         print('Failed to sign in: ${response.body}');
//       }
//     } catch (error) {
//       print('Sign in failed: $error');
//     }
//   }
//
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: ElevatedButton(
//         onPressed: signInWithGoogle,
//         child: Text('Sign in with Google'),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in_web/google_sign_in_web.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     clientId: '964988269089-ur331nnlu4bbvkcnmmue6ul8vanmp7l8.apps.googleusercontent.com', // Add your client ID here
//   );
//
//   // Using signInSilently for auto sign-in if possible
//   Future<void> signInSilently() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently();
//       if (googleUser == null) {
//         // If the user is not signed in, trigger the sign-in flow
//         signInWithGoogle();
//       } else {
//         final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//         final idToken = googleAuth.idToken;
//         // Send the token to the backend
//         await sendTokenToBackend(idToken);
//       }
//     } catch (error) {
//       print('Sign-in silently failed: $error');
//     }
//   }
//
//   // Use renderButton for rendering the Google Sign-In button on the web
//   Future<void> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         // User canceled the sign-in process
//         return;
//       }
//
//       final GoogleSignInAuthentication googleAuth =
//       await googleUser.authentication;
//
//       // Extract the ID token
//       final idToken = googleAuth.idToken;
//
//       // Send the token to the backend
//       await sendTokenToBackend(idToken);
//     } catch (error) {
//       print('Sign-in failed: $error');
//     }
//   }
//
//   // Sending the token to backend
//   Future<void> sendTokenToBackend(String? idToken) async {
//     if (idToken == null) return;
//
//     final response = await http.post(
//       Uri.parse('http://192.168.2.105:3000/googleSignIn'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'idToken': idToken}),
//     );
//
//     if (response.statusCode == 200) {
//       // Parse the response
//       final data = jsonDecode(response.body);
//       print('Login Successful: ${data['message']}');
//       print('User Details: ${data['user']}');
//     } else {
//       print('Failed to sign in: ${response.body}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: signInWithGoogle,
//           child: Text('Sign in with Google'),
//         ),
//       ),
//     );
//   }
// }

