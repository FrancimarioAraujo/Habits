import 'package:click/app/modules/routine/controller/routine_controller.dart';
import 'package:click/app/modules/routine/model/routine_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';

class CheckBoxRoutine extends StatefulWidget {
  RoutineModel routine;
  CheckBoxRoutine(this.routine, {Key? key}) : super(key: key);

  @override
  State<CheckBoxRoutine> createState() => _CheckBoxRoutineState();
}

class _CheckBoxRoutineState extends State<CheckBoxRoutine> {
  @override
  Widget build(BuildContext context) {
    ColorScheme themeColor = Theme.of(context).colorScheme;
    final routinesController = Modular.get<RoutineController>();
    RoutineModel routine = routinesController.getRoutine(widget.routine);
    return Transform.scale(
      scale: 2.0.r,
      child: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.all(themeColor.secondary),
        value: routine.concluded,
        shape: const CircleBorder(),
        onChanged: (value) async {
          await routinesController.concludeOrMarkOffRoutine(routine, value!);
          if (value) {
            SnackBar taskConcluded = SnackBar(
              content: Text(
                "taskChecked".i18n(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              duration: const Duration(milliseconds: 500),
            );
            ScaffoldMessenger.of(context).showSnackBar(taskConcluded);
          }
          setState(() {});
        },
      ),
    );
  }
}
