import 'package:click/app/components/BottomNavigationBar.dart';
import 'package:click/app/components/NewRoutineAlertDialog.dart';
import 'package:click/app/db/RoutinesDB.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getRoutines() {
    RoutinesDB.instance.getRoutines().then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    getRoutines();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Inicio"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => NewRoutineAlertDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
