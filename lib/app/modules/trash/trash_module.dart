import 'package:click/app/modules/routine/controller/routine_controller.dart';
import 'package:click/app/modules/trash/view/trash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TrashModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => RoutineController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => TrashPage()),
  ];
}
