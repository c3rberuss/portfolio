import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class HomeView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HomeView is working', 
          style: TextStyle(fontSize:20),
        ),
      ),
    );
  }
}
  