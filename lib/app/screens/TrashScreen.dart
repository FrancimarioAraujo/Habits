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

    return routinesProvider.getAllRoutinesSelectedOnTrash().isEmpty
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
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await routinesProvider.restoreElementsSelectedFromTrash();
              },
              child: const Icon(Icons.restore_from_trash),
            ),
          );
  }
}
