import 'package:chakh_le_admin/utils/suborder.dart';
import 'package:flutter/material.dart';

class subOrderPage extends StatefulWidget {
  @override
  _subOrderPageState createState() => _subOrderPageState();
}

class _subOrderPageState extends State<subOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
      return SubOrderCard(context,'Burger',100,10,1000);
    },
    ),
    );
  }
}
