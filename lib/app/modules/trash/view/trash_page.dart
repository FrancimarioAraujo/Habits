import 'package:click/app/modules/trash/view/components/clear_trash_alert_dialog.dart';
import 'package:click/app/modules/routine/controller/routine_controller.dart';
import 'package:click/app/modules/trash/view/trash_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import '../../../../assets/constants.dart';

class TrashPage extends StatefulWidget {
  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  final routinesController = Modular.get<RoutineController>();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(
            Constants.WIDTH_DEVICE_DEFAULT, Constants.HEIGHT_DEVICE_DEFAULT));
    return routinesController.routinesOnTrash.isEmpty
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("trash".i18n()),
            ),
            body: TrashBody(),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("trash".i18n()),
            ),
            body: TrashBody(),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (routinesController.routinesSelectedOnTrash.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10).r,
                    child: FloatingActionButton(
                      heroTag: "restoreFromTrash",
                      onPressed: () async {
                        await routinesController
                            .restoreElementsSelectedFromTrash()
                            .then((_) {
                          var itensRestored = SnackBar(
                            content: Text(
                              "itemsRestoredFromTrash".i18n(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                            duration: const Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(itensRestored);
                        });
                      },
                      child: const Icon(Icons.restore_from_trash),
                    ),
                  ),
                FloatingActionButton(
                  heroTag: "clearTrash",
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          ClearTrashAlertDialog(),
                    );
                  },
                  child: const Icon(
                    Icons.delete_forever,
                  ),
                ),
              ],
            ),
          );
  }
}
