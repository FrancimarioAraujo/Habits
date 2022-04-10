import 'package:click/app/providers/routinesProvider/RoutinesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClearTrashAlertDialog extends StatefulWidget {
  @override
  _ClearTrashAlertDialogState createState() => _ClearTrashAlertDialogState();
}

class _ClearTrashAlertDialogState extends State<ClearTrashAlertDialog> {
  late RoutinesProvider routinesProvider;
  @override
  Widget build(BuildContext context) {
    routinesProvider = Provider.of<RoutinesProvider>(context);
    return AlertDialog(
      title: const Text('Esvaziar Lixeira'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text(
                'Se clicar em "Esvaziar", todas as tarefas da lixeira serão apagadas permanentemente!'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Esvaziar',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () async {
            await routinesProvider.clearTrash().then((_) {
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
