import 'package:chatter_app/screens/screen.dart';
import 'package:chatter_app/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      title:"chatter",
      debugShowCheckedModeBanner:false,
      home: HomeScreen(),
    );
  }
}