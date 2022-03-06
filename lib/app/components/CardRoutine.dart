import 'package:click/app/models/Routine.dart';
import 'package:flutter/material.dart';

class CardRoutine extends StatefulWidget {
  Routine routine;
  CardRoutine(this.routine);
  @override
  State<CardRoutine> createState() => _CardRoutineState();
}

class _CardRoutineState extends State<CardRoutine> {
  @override
  Widget build(BuildContext context) {
    ColorScheme themeColor = Theme.of(context).colorScheme;
    return Card(
      color: themeColor.primary,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: themeColor.tertiary,
          child: Text(
            widget.routine.name.substring(0, 1).toUpperCase(),
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
            value: true,
            shape: const CircleBorder(),
            onChanged: (bool? value) {},
          ),
        ),
      ),
    );
  }
}
