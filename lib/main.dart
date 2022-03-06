import 'package:click/app/MyApp.dart';
import 'package:click/app/providers/routinesProvider/RoutinesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RoutinesProvider(),
      child: const MyApp(),
    ),
  );
}
