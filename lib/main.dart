import 'package:flutter/material.dart';
import 'package:mumble_client/screens/connect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mumble Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const Connect(title: 'Mumble Client'),
      home: const ConnectScreen(title: 'Connect to Server'),
    );
  }
}
