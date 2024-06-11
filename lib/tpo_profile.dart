import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:placementactcell/tpo_add_page.dart';
import 'package:placementactcell/tpo_home_page.dart';

class TPOProfilePage extends StatefulWidget {
  final String tpoLoginId;

  TPOProfilePage({required this.tpoLoginId});

  @override
  _TPOProfilePageState createState() => _TPOProfilePageState();
}

class _TPOProfilePageState extends State<TPOProfilePage> {
  late String _name;
  late String _email;
  late String _college;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _collegeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch TPO details based on the login ID
    fetchTPODetails(widget.tpoLoginId);
  }

  void fetchTPODetails(String tpoLoginId) async {
    try {
      // Replace 'tpoCollection' with the actual collection name in your Firestore
      DocumentSnapshot tpoSnapshot = await FirebaseFirestore.instance
          .collection('tpoCollection')
          .doc(tpoLoginId)
          .get();

      if (tpoSnapshot.exists) {
        // Update state and controllers with the fetched details
        setState(() {
          _name = tpoSnapshot['name'];
          _email = tpoSnapshot['email'];
          _college = tpoSnapshot['college'];
        });

        _nameController.text = _name;
        _emailController.text = _email;
        _collegeController.text = _college;
      } else {
        // Handle the case where the document does not exist
        print('TPO document does not exist');
      }
    } catch (error) {
      // Handle any errors that occur during the fetch
      print('Error fetching TPO details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TPO Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _collegeController,
              decoration: InputDecoration(labelText: 'College'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement update logic here
                // For demonstration, print updated values
                print('Updated Name: ${_nameController.text}');
                print('Updated Email: ${_emailController.text}');
                print('Updated College: ${_collegeController.text}');
                print('Updated Password: ${_passwordController.text}');
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Set the index for Profile
        onTap: (index) {
          switch (index) {
            case 0:
            // Home
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TPOHomePage()),
              );
              break;
            case 1:
            // Add
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TPOAddPage(tpoLoginId: '',)),
              );
              break;
            case 2:
            // Profile (Current Page)
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
