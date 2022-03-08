import 'package:click/app/components/CardRoutine.dart';
import 'package:click/app/providers/routinesProvider/RoutinesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late RoutinesProvider routinesProvider;
  bool _loading = true;
  bool _hasRoutines = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<RoutinesProvider>(context).fetchRoutines().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    routinesProvider = Provider.of<RoutinesProvider>(context);
    ColorScheme themeColor = Theme.of(context).colorScheme;
    _hasRoutines = routinesProvider.routines.isNotEmpty;
    return _loading
        ? Center(
            child: CircularProgressIndicator(
              color: themeColor.secondary,
            ),
          )
        : _hasRoutines
            ? ListView.builder(
                itemCount: routinesProvider.routines.length,
                itemBuilder: (context, index) {
                  return CardRoutine(routinesProvider.routines[index]);
                },
              )
            : const Center(
                child: Text(
                  "Não há Hábitos",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              );
  }
}
