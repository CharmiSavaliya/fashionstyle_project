import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  get currentUser => null;

  Future<dynamic> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('>>>>>>>>>>>> 111 $credential');
      // Save user data to Firestore
      await _firestore.collection('users').doc(credential.user?.uid).set({
        'email': email,
        'name': name,
        'password': password,
        // add other user fields here as needed
      });
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('>>>>>>>>>>>> 111555 $e');

      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print('?>>>>>> $e');
      return null;
    }
  }

  Future<dynamic> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

  Future<void> signout() async {
    try {
      await auth.signOut();
    } catch (e) {
      if (e is FirebaseAuthException) {
        print("FirebaseAuthException: ${e.message}");
      } else {
        print("An error occurred: ${e.toString()}");
      }
    }
  }

  Future<dynamic> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential = await auth.signInWithCredential(credential);

    return userCredential.user;
  }

  // Method to save or update user profile data
  Future<void> updateUserProfile(String name, String phoneNumber, String gender, String countryCode,
      {String? imageUrl}) async {
    User? user = auth.currentUser;
    print("............$user");
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update(
        {
          'name': name,
          'phoneNumber': phoneNumber,
          'gender': gender,
          'countryCode': countryCode,
          'imageUrl': imageUrl,
        },
      );
    }
  }

  // Method to get user profile data
  Future getUserProfile() async {
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      print("==========>>>${userDoc.data()}");
      return userDoc.data();
    }
    return null;
  }
}
