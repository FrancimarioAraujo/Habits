

import 'package:click/app/modules/trash/trash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RoutineModule extends Module {
  @override
  final List<Bind> binds = [
  
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/trash', child: (_, args) => TrashPage()),
  ];
}
