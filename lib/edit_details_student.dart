import 'package:flutter/material.dart';

class EditStudentDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student Details'),
      ),
      body: SingleChildScrollView( // Use SingleChildScrollView to enable scrolling
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(labelText: '10th marks'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(labelText: '12th marks'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'graduation degree name'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'graduation percentage'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'pg degree name'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'pg percentage'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Handle form submission to update student details
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
