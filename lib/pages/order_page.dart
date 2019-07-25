import 'package:chakh_le_admin/utils/order_card.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();

//  final String status;
//  final GetOrder order;
//
//  OrderPage({this.order, this.status})
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return orderCard();
        },
      ),
    );
  }
}
