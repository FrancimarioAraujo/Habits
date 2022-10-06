

import 'package:click/app/modules/routine/routine_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../trash/trash_page.dart';

class RoutineModule extends Module {
  @override
  final List<Bind> binds = [
  
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => RoutinePage()),
    ChildRoute('/trash', child: (_, args) => TrashPage()),
  ];
}
