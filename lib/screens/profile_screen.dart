import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(children: [
              CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/avatar.jpg')),
              SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Karan Bhambere',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text('Member since 2025')
              ])
            ]),
            SizedBox(height: 24),
            ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Saved Salon'),
                subtitle: Text('Near Shivaji Nagar')),
            ListTile(
                leading: Icon(Icons.payment),
                title: Text('Payments'),
                subtitle: Text('Manage cards')),
            ListTile(
                leading: Icon(Icons.help_outline),
                title: Text('Help & Support'))
          ],
        ),
      ),
    );
  }
}
