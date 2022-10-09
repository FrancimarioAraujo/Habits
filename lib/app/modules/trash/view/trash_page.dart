import 'package:click/app/modules/trash/view/components/clear_trash_alert_dialog.dart';
import 'package:click/app/modules/routine/controller/routine_controller.dart';
import 'package:click/app/modules/trash/view/trash_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../../../../assets/constants.dart';

class TrashPage extends StatefulWidget {
  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  late RoutineController routinesProvider;
  @override
  Widget build(BuildContext context) {
    routinesProvider = Provider.of<RoutineController>(context);
    ScreenUtil.init(context,
        designSize: const Size(
            Constants.WIDTH_DEVICE_DEFAULT, Constants.HEIGHT_DEVICE_DEFAULT));
    return routinesProvider.getAllRoutinesOnTrash().isEmpty
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
                if (routinesProvider.getAllRoutinesSelectedOnTrash().isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10).r,
                    child: FloatingActionButton(
                      heroTag: "restoreFromTrash",
                      onPressed: () async {
                        await routinesProvider
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