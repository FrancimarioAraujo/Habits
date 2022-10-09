import 'package:click/app/modules/routine/controller/routine_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class ClearTrashAlertDialog extends StatefulWidget {
  @override
  _ClearTrashAlertDialogState createState() => _ClearTrashAlertDialogState();
}

class _ClearTrashAlertDialogState extends State<ClearTrashAlertDialog> {
  final routinesController = Modular.get<RoutineController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("clearTrash".i18n()),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text("warningCleanTrashPermanently".i18n()),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            "clear".i18n(),
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () async {
            await routinesController.clearTrash().then((_) {
              var trashCleaned = SnackBar(
                content: Text(
                  "cleanTrash".i18n(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                duration: const Duration(milliseconds: 500),
              );
              ScaffoldMessenger.of(context).showSnackBar(trashCleaned);
              Navigator.pop(context);
            });
          },
        ),
        TextButton(
          child: Text("cancel".i18n()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
