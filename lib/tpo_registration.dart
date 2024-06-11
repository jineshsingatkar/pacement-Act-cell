import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:placementactcell/tpo_login.dart';



class TPORegistrationPage extends StatefulWidget {
  @override
  _TPORegistrationPageState createState() => _TPORegistrationPageState();

}

class _TPORegistrationPageState extends State<TPORegistrationPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController orgController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _registerUser() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );


      // Store user details in Firestore
      await _firestore.collection('tpo').doc(userCredential.user?.uid).set({
        'name': nameController.text,
        'college': orgController.text,
        'password': passwordController.text,
        'email': emailController.text,
      });

      // Redirect to the WelcomePage.
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TPOLoginPage()));
    } catch (e) {
      // Handle registration error (e.g., show an error message)
      print('Registration failed: $e');

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: $e'),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TPO Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: nameController, // Add this line
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: emailController, // Add this line
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: orgController, // Add this line
              decoration: InputDecoration(labelText: 'Organization/College'),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: passwordController, // Add this line
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 10.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Re-enter Password'),
            ),

            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed:_registerUser,
              child: Text('Register'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Handle Google registration
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset('assets/google_logo.png', height: 20.0, width: 20.0),
                  SizedBox(width: 10.0),
                  Text('Register with Google'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
