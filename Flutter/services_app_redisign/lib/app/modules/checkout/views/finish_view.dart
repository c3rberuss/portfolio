import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class FinishView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FinishView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'FinishView is working', 
          style: TextStyle(fontSize:20),
        ),
      ),
    );
  }
}
  