import 'package:click/app/db/RoutinesDB.dart';
import 'package:click/app/models/Routine.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NewRoutineAlertDialog extends StatefulWidget {
  @override
  _NewRoutineAlertDialogState createState() => _NewRoutineAlertDialogState();
}

class _NewRoutineAlertDialogState extends State<NewRoutineAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = Uuid();

  String _generateNewRoutineId() {
    return _uuid.v4();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Adicionar novo hábito"),
      content: Form(
        key: _formKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nome",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor digite o nome do hábito";
                  }
                  return null;
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      RoutinesDB.instance.createRoutine(
                          Routine(id: _generateNewRoutineId(), name: "teste"));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Criar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
