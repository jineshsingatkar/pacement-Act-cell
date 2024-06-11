import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:placementactcell/student_login.dart';
import 'edit_details_student.dart';
import 'job_page.dart';
import 'job_profile.dart';
import 'main.dart';
import 'notification.dart';

void main() {
  runApp(MaterialApp(
    home: StudentHomePage(),
  ));
}

class StudentHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/siom_logo.jpeg', width: 40.0, height: 40.0),
            SizedBox(width: 5.0),
            Text('SIOM'),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        actions: [
          // Profile Icon
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigate to the profile page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentProfilePage()),
              );
            },
          ),
          // Notification Icon
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to the notifications page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()), // Use NotificationPage here
              );
            },
          ),
          // Logout Icon
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Implement the logout logic here
              // For example, show a confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Logout"),
                    content: Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          // Implement actual logout logic
                          // For now, just pop back to the login page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                        },
                        child: Text("Logout"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // Slider for Feeds (Upcoming Companies and Events)
          Container(
            height: 150.0,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('slider').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator(); // Loading indicator
                }

                List<DocumentSnapshot> documents = snapshot.data!.docs;

                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: documents.map((doc) {
                    return _buildEventBlock(
                      title: doc['name'],
                      date: doc['date'],
                      details: doc['message'],
                    );
                  }).toList(),
                );
              },
            ),
          ),
          // Horizontal Line
          Divider(
            color: Colors.black,
            thickness: 1.0,
          ),
          // Event Description
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EVENT1',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'The National Education Policy 2020 stresses on the core values and principles...',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to a page with the full description on tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullDescriptionPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Read more',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentHomePage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.work),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JobPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Navigate to the profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
Widget _buildEventBlock({
  required String title,
  required String date,
  required String details,
}) {
  return Container(
    width: 200.0, // Set the width of each block
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.blueGrey, // Customize the background color
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Date: $date',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          details,
          style: TextStyle(
            color: Colors.white,
          ),
        ),

      ],
    ),
  );

}
Widget _buildExpandableDescription(String description) {
  // Limit the description to the first three lines initially
  final String shortDescription = description.split('\n').take(3).join('\n');

  bool isExpanded = false;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        shortDescription,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      SizedBox(height: 8.0),
      GestureDetector(
        onTap: () {
          // Toggle the expansion state
          isExpanded = !isExpanded;
          // Rebuild the widget
          // Note: You might want to use a StatefulWidget for better state management
          // and to avoid potential issues with this approach.
          _buildExpandableDescription(description);
        },
        child: Text(
          isExpanded ? 'Read less' : 'Read more',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    ],
  );
}
class FullDescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Description'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EVENT1',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'the National Education Policy 2020 stresses on the core values and principle that education must develop not only the cognitive skills, that is, – both ‘foundational skills’ of literacy and numeracy and ‘higher-order’ skills such as critical thinking and problem solving – but also, social and emotional skills - also referred to as ‘soft skills’ -including cultural awareness and empathy, perseverance and grit, teamwork, leadership, communication, among others. The Policy aims and aspires to universalize the pre-primary education and provides special emphasis on the attainment of foundational literacy/numeracy in primary school and beyond for all by 2025. It recommends plethora of reforms at all levels of school education which seek to ensure quality of schools, transformation of the curriculum including pedagogy with 5+3+3+4 design covering children in the age group 3-18 years, reform in the current exams and assessment system, strengthening of teacher training, and restructuring the education regulatory framework. It seeks to increase public investment in education, strengthen the use of technology and increase focus on vocational and adult education, among others. It recommends that the curriculum load in each subject should be reduced to its ‘core essential’ content by making space for holistic, discussion and analysis-based learning.',
              style: TextStyle(fontSize: 16.0),
            ),
            // Add more content as needed
          ],
        ),
      ),
    );
  }
}