import 'package:click/app/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.black,
          secondary: Colors.amber,
          tertiary: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
