import 'package:flutter/material.dart';
import 'package:inventoryappflutter/Constant/app_logo.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About The App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                   
                    child: ClipOval(
                      child: Image.asset(
                        AppLogo.companyLogo,
                        height: MediaQuery.of(context).size.height / 6,
                        fit: BoxFit.scaleDown,
                        matchTextDirection: true,
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            Text(
              'App Name: Inventory Records Maintenance',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Version: 1.0.0',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'This app is designed to provide an awesome experience for users. '
              'You can explore various features and functionalities that will '
              'make your life easier and more enjoyable.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Developed by: Pawan Ginti',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Contact: PreyanshGinti@gmail.com',
              style: TextStyle(fontSize: 18),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality if needed
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Thank You!'),
                      content: Text('Thank you for using Awesome App!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Feedback'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}