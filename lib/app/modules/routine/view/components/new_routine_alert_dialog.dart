import 'package:click/app/modules/routine/controller/routine_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../../../../../assets/constants.dart';

class NewRoutineAlertDialog extends StatefulWidget {
  @override
  _NewRoutineAlertDialogState createState() => _NewRoutineAlertDialogState();
}

class _NewRoutineAlertDialogState extends State<NewRoutineAlertDialog> {
  final _formKey = GlobalKey<FormState>();

  final routinesController = Modular.get<RoutineController>();
  final TextEditingController _nameRoutineTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(
            Constants.WIDTH_DEVICE_DEFAULT, Constants.HEIGHT_DEVICE_DEFAULT));
    return AlertDialog(
      title: Text("addNewTask".i18n()),
      content: Form(
        key: _formKey,
        child: SizedBox(
          height: 150.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                controller: _nameRoutineTextController,
                decoration: InputDecoration(
                  labelText: "name".i18n(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "pleaseTypeTheNameTask".i18n();
                  }
                  return null;
                },
              ),
              SizedBox(
                width: double.infinity.w,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await routinesController
                          .createRoutine(_nameRoutineTextController.text);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("create".i18n()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
