import 'package:flutter/material.dart';
import 'package:nirogi/src/widgets/drawer.dart';

class DiseasesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(),
      body: Center(
        child: Text('Diseases'),
      ),
    );
  }
}
