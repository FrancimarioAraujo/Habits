import 'package:click/app/views/components/BottomNavigationBar.dart';
import 'package:click/app/views/components/NewRoutineAlertDialog.dart';
import 'package:click/app/routes/RoutesNames.dart';

import 'package:click/app/views/widgets/HomeBody.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Tarefas"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.pushNamed(context, RoutesNames.instance.trashScreen);
            },
          ),
        ],
      ),
      body: HomeBody(),
      floatingActionButton: FloatingActionButton(
        heroTag: "addNewRoutine",
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => NewRoutineAlertDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
