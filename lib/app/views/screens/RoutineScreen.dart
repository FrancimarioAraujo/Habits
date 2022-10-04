import 'package:click/app/models/Routine.dart';
import 'package:flutter/material.dart';

class RoutineScreen extends StatefulWidget {
  @override
  _RoutineScreenState createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Rotina"),
      ),
      body: const Text("Detalhes da Rotina"),
    );
  }
}
