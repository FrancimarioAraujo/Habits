import 'package:click/app/components/CardRoutine.dart';
import 'package:click/app/providers/routinesProvider/RoutinesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrashBody extends StatefulWidget {
  @override
  State<TrashBody> createState() => _TrashBodyState();
}

class _TrashBodyState extends State<TrashBody> {
  late RoutinesProvider routinesProvider;
  bool _loading = true;
  bool _hasRoutinesOnTrash = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<RoutinesProvider>(context).fetchRoutines().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    routinesProvider = Provider.of<RoutinesProvider>(context);
    ColorScheme themeColor = Theme.of(context).colorScheme;
    _hasRoutinesOnTrash = routinesProvider.getAllRoutinesOnTrash().isNotEmpty;
    return _loading
        ? Center(
            child: CircularProgressIndicator(
              color: themeColor.secondary,
            ),
          )
        : _hasRoutinesOnTrash
            ? ListView.builder(
                itemCount: routinesProvider.getAllRoutinesOnTrash().length,
                itemBuilder: (context, index) {
                  return CardRoutine(
                      routinesProvider.getAllRoutinesOnTrash()[index]);
                },
              )
            : const Center(
                child: Text(
                  "Lixeira Vazia",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              );
  }
}
