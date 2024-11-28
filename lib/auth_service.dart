import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final String _backendUrl = 'http://192.168.2.105:5000';  // Replace with your server URL

  // Sign In with Google and Firebase
  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return {'success': false, 'message': 'Google Sign-In canceled'};
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      final user = userCredential.user;
      if (user == null) {
        return {'success': false, 'message': 'Failed to retrieve user details'};
      }

      // Prepare the user data to send to backend
      Map<String, dynamic> userData = {
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'photoURL': user.photoURL,
      };

      // Send the user data to the backend
     await _sendUserDataToBackend(userData);

        return {
          'success': true,
          'data': {
            'user': userData,
          },
        };

    } catch (e) {
      print('Error during Google sign-in: $e');  // Additional logging for errors

      return {'success': false, 'message': e.toString()};
    }
  }

  // Send user data to backend
  Future<Map<String, dynamic>> _sendUserDataToBackend(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('$_backendUrl/api/auth/signup'), // Your Express endpoint
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {'success': false, 'message': 'Error saving user data'};
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Sign out from both Firebase and Google
  Future<void> signOut() async {
    await _auth.signOut();  // Sign out from Firebase
    await _googleSignIn.signOut();  // Sign out from Google
  }
}

//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   // Sign In with Google and Firebase
//   Future<Map<String, dynamic>> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         return {'success': false, 'message': 'Google Sign-In canceled'};
//       }
//
//       final GoogleSignInAuthentication googleAuth =
//       await googleUser.authentication;
//
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       final UserCredential userCredential =
//       await _auth.signInWithCredential(credential);
//
//       final user = userCredential.user;
//       if (user == null) {
//         return {'success': false, 'message': 'Failed to retrieve user details'};
//       }
//
//       return {
//         'success': true,
//         'data': {
//           'user': {
//             'uid': user.uid,
//             'email': user.email,
//             'displayName': user.displayName,
//             'photoURL': user.photoURL,
//           },
//         },
//       };
//     } catch (e) {
//       return {'success': false, 'message': e.toString()};
//     }
//   }
//
//   // Sign out from both Firebase and Google
//   Future<void> signOut() async {
//     await _auth.signOut();  // Sign out from Firebase
//     await _googleSignIn.signOut();  // Sign out from Google
//   }
// }