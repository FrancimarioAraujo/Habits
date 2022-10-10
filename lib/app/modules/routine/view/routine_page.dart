import 'package:click/app/modules/routine/controller/routine_controller.dart';
import 'package:click/app/modules/routine/view/components/card_routine.dart';
import 'package:click/app/modules/routine/view/components/new_routine_alert_dialog.dart';
import 'package:click/assets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({Key? key}) : super(key: key);

  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  final routinesController = Modular.get<RoutineController>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routinesController.fetchRoutines();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme themeColor = Theme.of(context).colorScheme;
    ScreenUtil.init(context,
        designSize: const Size(
            Constants.WIDTH_DEVICE_DEFAULT, Constants.HEIGHT_DEVICE_DEFAULT));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("tasks".i18n()),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Modular.to.pushNamed('/trash/');
            },
          ),
        ],
      ),
      body: Observer(builder: (_) {
        if (routinesController.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: themeColor.secondary,
            ),
          );
        }
        if (!routinesController.hasRoutinesOutSideFromTrash) {
          return Center(
            child: Text(
              "thereAreNoTasks".i18n(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
          );
        }
        return Observer(
          builder: (_) => ListView.builder(
            itemCount: routinesController.routinesOutSideFromTrash.length,
            itemBuilder: (context, index) {
              return CardRoutine(
                  routinesController.routinesOutSideFromTrash[index]);
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        heroTag: "addNewRoutine",
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => NewRoutineAlertDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
