import 'package:click/app/modules/routine/controller/routine_controller.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class ClearTrashAlertDialog extends StatefulWidget {
  @override
  _ClearTrashAlertDialogState createState() => _ClearTrashAlertDialogState();
}

class _ClearTrashAlertDialogState extends State<ClearTrashAlertDialog> {
  late RoutineController routinesProvider;
  @override
  Widget build(BuildContext context) {
    routinesProvider = Provider.of<RoutineController>(context);
    return AlertDialog(
      title: const Text('Esvaziar Lixeira'),
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
            await routinesProvider.clearTrash().then((_) {
              const trashCleaned = SnackBar(
                content: Text(
                  'Lixeira limpada',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                duration: Duration(milliseconds: 500),
              );
              ScaffoldMessenger.of(context).showSnackBar(trashCleaned);
              Navigator.pop(context);
            });
          },
        ),
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
