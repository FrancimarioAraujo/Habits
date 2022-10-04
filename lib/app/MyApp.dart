import 'package:click/app/routes/Routes.dart';
import 'package:click/app/views/screens/HomeScreen.dart';
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
          primary: Colors.blue,
          secondary: Colors.orange,
          tertiary: Colors.white,
        ),
      ),
      home: const HomeScreen(),
      routes: Routes.routes,
    );
  }
}
