import 'package:flutter/material.dart';

class AddNewRoutineScreen extends StatefulWidget {
  @override
  _AddNewRoutineScreenState createState() => _AddNewRoutineScreenState();
}

class _AddNewRoutineScreenState extends State<AddNewRoutineScreen> {
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
