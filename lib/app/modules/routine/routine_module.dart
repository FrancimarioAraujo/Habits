import 'package:click/app/modules/routine/view/routine_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../trash/trash_module.dart';
import '../trash/view/trash_page.dart';

class RoutineModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const RoutinePage()),
    ModuleRoute('/trash', module: TrashModule())
  ];
}
