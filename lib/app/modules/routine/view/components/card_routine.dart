import 'package:click/app/modules/routine/model/routine_model.dart';
import 'package:click/app/modules/routine/controller/routine_controller.dart';
import 'package:click/app/modules/routine/view/components/checkbox_routine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../assets/constants.dart';

class CardRoutine extends StatefulWidget {
  RoutineModel routine;
  CardRoutine(this.routine, {Key? key}) : super(key: key);
  @override
  State<CardRoutine> createState() => _CardRoutineState();
}

class _CardRoutineState extends State<CardRoutine> {
  final routinesController = Modular.get<RoutineController>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
          key: ValueKey<RoutineModel>(widget.routine),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (DismissDirection direction) async {
            await routinesController.deleteRoutine(widget.routine);
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
                trailing: CheckBoxRoutine(widget.routine)),
          ),
        ),
      ),
    );
  }
}
