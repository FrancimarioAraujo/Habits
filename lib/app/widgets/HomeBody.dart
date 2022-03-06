import 'package:click/app/components/CardRoutine.dart';
import 'package:click/app/db/RoutinesDB.dart';
import 'package:click/app/providers/routinesProvider/RoutinesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late RoutinesProvider routinesProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<RoutinesProvider>(context).fetchRoutines();
  }

  @override
  Widget build(BuildContext context) {
    routinesProvider = Provider.of<RoutinesProvider>(context);
    return ListView.builder(
      itemCount: routinesProvider.routines.length,
      itemBuilder: (context, index) {
        return CardRoutine(routinesProvider.routines[index]);
      },
    );
  }
}