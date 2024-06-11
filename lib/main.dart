import 'package:flutter/material.dart';
import 'package:placementactcell/student_login.dart';
import 'package:placementactcell/tpo_login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyAQ1bul-LX56-sRThbOuH1gwNC5PYpj90U',
      authDomain: 'placementact-f9c82.firebaseapp.com',
      projectId: 'placementact-f9c82',
      storageBucket: 'placementact-f9c82.appspot.com',
      messagingSenderId: '372949152424',
      appId: '1:372949152424:android:a2a3e8fd5bbf0369db089d',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentLoginPage()),
                );
              },
              child: Text('Student Login'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TPOLoginPage()),
                );
              },
              child: Text('TPO Login'),
            ),
          ],
        ),
      ),
    );
  }
}
