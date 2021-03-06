import 'package:click/app/models/Routine.dart';
import 'package:click/app/providers/routinesProvider/RoutinesProvider.dart';
import 'package:click/app/routes/RoutesNames.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CardTrash extends StatefulWidget {
  Routine routine;
  CardTrash(this.routine);
  @override
  State<CardTrash> createState() => _CardTrashState();
}

class _CardTrashState extends State<CardTrash> {
  late RoutinesProvider routinesProvider;
  final RoutesNames _routesNames = RoutesNames.instance;
  bool? _selected;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _selected = widget.routine.selectedToRestore;
  }

  @override
  Widget build(BuildContext context) {
    routinesProvider = Provider.of<RoutinesProvider>(context);
    ColorScheme themeColor = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, _routesNames.routineScreen);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
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
                  routinesProvider.selectOrDeselectToRestore(
                      widget.routine, value!);
                  setState(() {
                    _selected = value;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
