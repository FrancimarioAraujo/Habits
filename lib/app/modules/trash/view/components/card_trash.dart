import 'package:click/app/modules/routine/model/routine_model.dart';
import 'package:click/app/modules/routine/controller/routine_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../../../assets/constants.dart';

class CardTrash extends StatefulWidget {
  RoutineModel routine;
  CardTrash(this.routine);
  @override
  State<CardTrash> createState() => _CardTrashState();
}

class _CardTrashState extends State<CardTrash> {
  late RoutineController routinesProvider;
  bool? _selected;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _selected = widget.routine.selectedToRestore;
  }

  @override
  Widget build(BuildContext context) {
    routinesProvider = Provider.of<RoutineController>(context);
    ScreenUtil.init(context,
        designSize: const Size(
            Constants.WIDTH_DEVICE_DEFAULT, Constants.HEIGHT_DEVICE_DEFAULT));
    ColorScheme themeColor = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, _routesNames.routineScreen);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5).r,
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
