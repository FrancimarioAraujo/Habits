import 'package:click/app/models/routine_model.dart';
import 'package:click/app/controllers/routines_controller.dart';
import 'package:click/app/routes/RoutesNames.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CardRoutine extends StatefulWidget {
  RoutineModel routine;
  CardRoutine(this.routine);
  @override
  State<CardRoutine> createState() => _CardRoutineState();
}

class _CardRoutineState extends State<CardRoutine> {
  late RoutinesController routinesProvider;
  final RoutesNames _routesNames = RoutesNames.instance;
  bool? _selected;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _selected = widget.routine.concluded;
  }

  @override
  Widget build(BuildContext context) {
    routinesProvider = Provider.of<RoutinesController>(context);
    ColorScheme themeColor = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, _routesNames.routineScreen);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Dismissible(
          background: Container(
            color: Colors.red,
          ),
          key: ValueKey<RoutineModel>(widget.routine),
          onDismissed: (DismissDirection direction) async {
            await routinesProvider.addOrRemoveRoutineFromTrash(
                routine: widget.routine, onTrash: true);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: themeColor.primary,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: themeColor.tertiary,
                child: Text(
                  widget.routine.name.substring(0, 1),
                  style: TextStyle(
                    color: themeColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                widget.routine.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeColor.tertiary,
                ),
              ),
              trailing: Transform.scale(
                scale: 2.0,
                child: Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.all(themeColor.secondary),
                  value: _selected,
                  shape: const CircleBorder(),
                  onChanged: (value) {
                    routinesProvider
                        .concludeOrMarkOffRoutine(widget.routine, value!)
                        .then((_) {
                      if (value) {
                        const taskConcluded = SnackBar(
                          content: Text(
                            'Atividade marcada como concluida!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                            ),
                          ),
                          duration: Duration(milliseconds: 500),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(taskConcluded);
                      }
                    });
                    setState(() {
                      _selected = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
