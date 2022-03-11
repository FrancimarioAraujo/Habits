import 'package:click/app/widgets/TrashBody.dart';
import 'package:flutter/material.dart';

class TrashScreen extends StatefulWidget {
  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Lixeira"),
      ),
      body: TrashBody(),
    );
  }
}
