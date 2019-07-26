import 'package:chakh_le_admin/utils/suborder.dart';
import 'package:chakh_le_admin/utils/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List<DropdownMenuItem<String>> listMode = [];
  List<DropdownMenuItem<String>> listType = [];
  List<DropdownMenuItem<String>> listAcceptedBy = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return TransactionCard(100, listMode, listType, listAcceptedBy);
        },
      ),
    );
  }

  void loadData() {
    listMode = [];
    listAcceptedBy = [];
    listType = [];
    listMode.add(DropdownMenuItem(child: Text('Credit Card'), value: 'CC'));
    listMode.add(DropdownMenuItem(child: Text('Debit Card'), value: 'DC'));
    listMode.add(DropdownMenuItem(child: Text('Paytm'), value: 'PTM'));
    listMode.add(DropdownMenuItem(child: Text('Cash'), value: 'C'));
    listMode.add(DropdownMenuItem(child: Text('InstaMojo'), value: 'IMJ'));
    listMode.add(DropdownMenuItem(child: Text('Paytm Gateway'), value: 'PTMG'));
    listType.add(DropdownMenuItem(child: Text('Cash'), value: 'C'));
    listType.add(DropdownMenuItem(child: Text('Online'), value: 'O'));
    listAcceptedBy
        .add(DropdownMenuItem(child: Text('Suresh'), value: 'Suresh'));
    listAcceptedBy
        .add(DropdownMenuItem(child: Text('Ramesh'), value: 'Ramesh'));
    listAcceptedBy
        .add(DropdownMenuItem(child: Text('Kalpesh'), value: 'Kalpesh'));
  }
}
