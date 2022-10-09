import 'package:click/app/modules/routine/model/routine_model.dart';
import 'package:click/app/modules/routine/controller/routine_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../../../../../assets/constants.dart';

class CardRoutine extends StatefulWidget {
  RoutineModel routine;
  CardRoutine(this.routine);
  @override
  State<CardRoutine> createState() => _CardRoutineState();
}

class _CardRoutineState extends State<CardRoutine> {
  final routinesController = Modular.get<RoutineController>();
  bool? _selected;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _selected = widget.routine.concluded;
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme themeColor = Theme.of(context).colorScheme;
    ScreenUtil.init(context,
        designSize: const Size(
            Constants.WIDTH_DEVICE_DEFAULT, Constants.HEIGHT_DEVICE_DEFAULT));
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5).r,
        child: Dismissible(
          background: Container(
            color: Colors.red,
          ),
          key: ValueKey<RoutineModel>(widget.routine),
          onDismissed: (DismissDirection direction) async {
            await routinesController.addOrRemoveRoutineFromTrash(
                routine: widget.routine, onTrash: true);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
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
                scale: 2.0.r,
                child: Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.all(themeColor.secondary),
                  value: _selected,
                  shape: const CircleBorder(),
                  onChanged: (value) {
                    routinesController
                        .concludeOrMarkOffRoutine(widget.routine, value!)
                        .then((_) {
                      if (value) {
                        var taskConcluded = SnackBar(
                          content: Text(
                            "taskChecked".i18n(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                            ),
                          ),
                          duration: const Duration(milliseconds: 500),
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
