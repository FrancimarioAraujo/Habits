import 'package:click/app/MyApp.dart';
import 'package:click/app/controllers/routines_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RoutinesController(),
      child: const MyApp(),
    ),
  );
}
