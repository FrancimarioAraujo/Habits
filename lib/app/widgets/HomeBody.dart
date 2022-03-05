import 'package:click/app/providers/routinesProvider/RoutinesProvider.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    RoutinesProvider.instance.fetchRoutines();
  }

  @override
  Widget build(BuildContext context) {
    print(RoutinesProvider.instance.routines);
    return ListView.builder(
      itemCount: RoutinesProvider.instance.routines.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(RoutinesProvider.instance.routines[index].name),
        );
      },
    );
  }
}
