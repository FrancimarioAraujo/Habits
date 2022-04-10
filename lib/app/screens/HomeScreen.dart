import 'package:click/app/components/BottomNavigationBar.dart';
import 'package:click/app/components/NewRoutineAlertDialog.dart';
import 'package:click/app/routes/RoutesNames.dart';

import 'package:click/app/widgets/HomeBody.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Hábitos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.pushNamed(context, RoutesNames.instance.trashScreen);
            },
          ),
        ],
      ),
      body: HomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => NewRoutineAlertDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
