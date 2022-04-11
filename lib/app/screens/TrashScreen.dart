import 'package:click/app/components/ClearTrashAlertDialog.dart';
import 'package:click/app/providers/routinesProvider/RoutinesProvider.dart';
import 'package:click/app/widgets/TrashBody.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrashScreen extends StatefulWidget {
  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  late RoutinesProvider routinesProvider;
  @override
  Widget build(BuildContext context) {
    routinesProvider = Provider.of<RoutinesProvider>(context);

    return routinesProvider.getAllRoutinesOnTrash().isEmpty
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Lixeira"),
            ),
            body: TrashBody(),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Lixeira"),
            ),
            body: TrashBody(),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (routinesProvider.getAllRoutinesSelectedOnTrash().isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: FloatingActionButton(
                      onPressed: () async {
                        await routinesProvider
                            .restoreElementsSelectedFromTrash()
                            .then((_) {
                          const itensRestored = SnackBar(
                            content: Text(
                              'Itens restaurados da Lixeira',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                            duration: Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(itensRestored);
                        });
                      },
                      child: const Icon(Icons.restore_from_trash),
                    ),
                  ),
                FloatingActionButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          ClearTrashAlertDialog(),
                    );
                  },
                  child: const Icon(
                    Icons.delete_forever,
                  ),
                ),
              ],
            ),
          );
  }
}
