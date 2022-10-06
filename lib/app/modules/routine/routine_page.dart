import 'package:click/app/views/components/NewRoutineAlertDialog.dart';
import 'package:click/app/views/widgets/HomeBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({Key? key}) : super(key: key);

  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
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
              Modular.to.pushNamed('/trash');
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
