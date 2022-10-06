import 'package:click/app/views/components/CardRoutine.dart';
import 'package:click/app/modules/routine/routine_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late RoutineController routinesProvider;
  bool _loading = true;
  bool _hasRoutines = false;
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
    _hasRoutines = routinesProvider.getAllRoutinesOutSideFromTrash().isNotEmpty;
    return _loading
        ? Center(
            child: CircularProgressIndicator(
              color: themeColor.secondary,
            ),
          )
        : _hasRoutines
            ? ListView.builder(
                itemCount:
                    routinesProvider.getAllRoutinesOutSideFromTrash().length,
                itemBuilder: (context, index) {
                  return CardRoutine(
                      routinesProvider.getAllRoutinesOutSideFromTrash()[index]);
                },
              )
            : const Center(
                child: Text(
                  "Não há Tarefas",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              );
  }
}
