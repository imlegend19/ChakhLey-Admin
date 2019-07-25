import 'package:chakh_le_admin/utils/suborder.dart';
import 'package:chakh_le_admin/utils/transaction_card.dart';
import 'package:flutter/material.dart';

class ViewDetailsPage extends StatefulWidget {
  @override
  _ViewDetailsPageState createState() => _ViewDetailsPageState();
}

class _ViewDetailsPageState extends State<ViewDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return TransactionCard(100,'Aaeeeee','ede','dqssd');
        },
      ),
    );;
  }
}
