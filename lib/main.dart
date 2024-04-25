import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_api/controller/provider.dart';
import 'package:social_media_api/view/login_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage()),
    );
  }
}