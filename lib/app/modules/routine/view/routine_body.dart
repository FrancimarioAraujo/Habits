import 'package:click/app/modules/routine/view/components/card_routine.dart';
import 'package:click/app/modules/routine/controller/routine_controller.dart';
import 'package:click/assets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool _loading = true;
  bool _hasRoutines = false;
  final routinesController = Modular.get<RoutineController>();
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
    _hasRoutines =
        routinesController.getAllRoutinesOutSideFromTrash().isNotEmpty;
    ScreenUtil.init(context,
        designSize: const Size(
            Constants.WIDTH_DEVICE_DEFAULT, Constants.HEIGHT_DEVICE_DEFAULT));
    return _loading
        ? Center(
            child: CircularProgressIndicator(
              color: themeColor.secondary,
            ),
          )
        : _hasRoutines
            ? Observer(
                builder: (_) => ListView.builder(
                  itemCount: routinesController
                      .getAllRoutinesOutSideFromTrash()
                      .length,
                  itemBuilder: (context, index) {
                    return CardRoutine(routinesController
                        .getAllRoutinesOutSideFromTrash()[index]);
                  },
                ),
              )
            : Center(
                child: Text(
                  "thereAreNoTasks".i18n(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              );
  }
}
