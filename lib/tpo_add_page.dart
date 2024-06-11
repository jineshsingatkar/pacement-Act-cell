import 'package:flutter/material.dart';
import 'package:placementactcell/add_slider.dart';
import 'add_event.dart';
import 'add_job.dart';
import 'tpo_home_page.dart'; // Import your tpo_home_page.dart
import 'tpo_profile.dart'; // Import your tpo_profile.dart


class TPOAddPage extends StatelessWidget {
  final String tpoLoginId;

  // Receive the TPO login ID through the constructor
  TPOAddPage({required this.tpoLoginId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TPO Add Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Redirect to the slider page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddSliderPage(tpoLoginId: '',)),
                );
              },
              child: Text('Slider'),
            ),
            ElevatedButton(
              onPressed: () {
                // Redirect to the event page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>AddEventPage(tpoLoginId: '',)),
                );
              },
              child: Text('Event'),
            ),
            ElevatedButton(
              onPressed: () {
                // Redirect to the job page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddJobPage(tpoLoginId: '',)),
                );
              },
              child: Text('Job'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Set the index for Add
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
            // Add (Current Page)
              break;
            case 2:
            // Profile
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TPOProfilePage(tpoLoginId: tpoLoginId)),
              );
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
