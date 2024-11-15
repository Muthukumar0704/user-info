import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userdata/screens/home_screen.dart';
import 'package:userdata/provider/user_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: const MyApp())
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Data',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Users'),
    );
  }
}
