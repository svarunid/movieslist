import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies List'),
      ),
      body: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                ' Geeksynergy Technologies Pvt Ltd',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Sanjayanagar, Bengaluru-56'),
              Text('+91XXXXXXXXX09'),
              Text('XXXXXX@gmail.com')
            ],
          ),
        ),
      ),
    );
  }
}
