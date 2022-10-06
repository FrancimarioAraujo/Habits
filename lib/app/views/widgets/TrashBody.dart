import 'package:click/app/views/components/CardRoutine.dart';
import 'package:click/app/views/components/CardTrash.dart';
import 'package:click/app/modules/routine/routine_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrashBody extends StatefulWidget {
  @override
  State<TrashBody> createState() => _TrashBodyState();
}

class _TrashBodyState extends State<TrashBody> {
  late RoutineController routinesProvider;
  bool _loading = true;
  bool _hasRoutinesOnTrash = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<RoutineController>(context).fetchRoutines().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    routinesProvider = Provider.of<RoutineController>(context);
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
                  return CardTrash(
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
