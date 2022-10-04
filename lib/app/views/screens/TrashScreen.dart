import 'package:click/app/views/components/ClearTrashAlertDialog.dart';
import 'package:click/app/controllers/routines_controller.dart';
import 'package:click/app/views/widgets/TrashBody.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrashScreen extends StatefulWidget {
  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  late RoutinesController routinesProvider;
  @override
  Widget build(BuildContext context) {
    routinesProvider = Provider.of<RoutinesController>(context);

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
                      heroTag: "restoreFromTrash",
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
                  heroTag: "clearTrash",
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
