import 'package:click/app/modules/routine/view/components/card_routine.dart';
import 'package:click/app/modules/trash/view/components/card_trash.dart';
import 'package:click/app/modules/routine/controller/routine_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../../../../assets/constants.dart';

class TrashBody extends StatefulWidget {
  @override
  State<TrashBody> createState() => _TrashBodyState();
}

class _TrashBodyState extends State<TrashBody> {
  final routinesController = Modular.get<RoutineController>();
  bool _loading = true;
  bool _hasRoutinesOnTrash = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routinesController.fetchRoutines().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme themeColor = Theme.of(context).colorScheme;
    _hasRoutinesOnTrash = routinesController.routinesOnTrash.isNotEmpty;
    ScreenUtil.init(context,
        designSize: const Size(
            Constants.WIDTH_DEVICE_DEFAULT, Constants.HEIGHT_DEVICE_DEFAULT));
    return _loading
        ? Center(
            child: CircularProgressIndicator(
              color: themeColor.secondary,
            ),
          )
        : _hasRoutinesOnTrash
            ? ListView.builder(
                itemCount: routinesController.routinesOnTrash.length,
                itemBuilder: (context, index) {
                  return CardTrash(routinesController.routinesOnTrash[index]);
                },
              )
            : Center(
                child: Text(
                  "cleanTrash".i18n(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              );
  }
}
