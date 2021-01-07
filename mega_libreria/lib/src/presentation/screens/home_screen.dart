import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:megalibreria/src/presentation/widgets/categories_grid.dart';
import 'package:megalibreria/src/presentation/widgets/custom_app_bar.dart';
import 'package:megalibreria/src/presentation/widgets/drawer.dart';
import 'package:megalibreria/src/presentation/widgets/header.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomAppBar(title: "Mega Librería", showSearchButton: true),
      body: Column(
        children: <Widget>[Header(text: "Categorías"), CategoriesGrid()],
      ),
    );
  }
}
