import 'package:click/app/modules/routine/view/components/new_routine_alert_dialog.dart';
import 'package:click/app/modules/routine/view/routine_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';

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
        title: Text("tasks".i18n()),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Modular.to.pushNamed('/trash/');
            },
          ),
        ],
      ),
      body: Observer(builder: (_) => HomeBody()),
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
