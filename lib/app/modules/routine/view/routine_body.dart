import 'package:click/app/modules/routine/view/components/card_routine.dart';
import 'package:click/app/modules/routine/controller/routine_controller.dart';
import 'package:click/assets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
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
            ? ListView.builder(
                itemCount:
                    routinesProvider.getAllRoutinesOutSideFromTrash().length,
                itemBuilder: (context, index) {
                  return CardRoutine(
                      routinesProvider.getAllRoutinesOutSideFromTrash()[index]);
                },
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
