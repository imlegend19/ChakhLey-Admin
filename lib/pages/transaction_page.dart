import 'package:chakh_le_admin/utils/transaction_saved_card.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List<DropdownMenuItem<String>> listMode = [];
  List<DropdownMenuItem<String>> listType = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _alerttransaction(context, 1000, listMode, listType),
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return TransactionSavedCard(100.0, 'CC', 'O', 'Ramesh');
        },
      ),
    );
  }

  void loadData() {
    listMode = [];
    listType = [];
    listMode.add(DropdownMenuItem(child: Text('Credit Card'), value: 'CC'));
    listMode.add(DropdownMenuItem(child: Text('Debit Card'), value: 'DC'));
    listMode.add(DropdownMenuItem(child: Text('Paytm'), value: 'PTM'));
    listMode.add(DropdownMenuItem(child: Text('Cash'), value: 'C'));
    listMode.add(DropdownMenuItem(child: Text('InstaMojo'), value: 'IMJ'));
    listMode.add(DropdownMenuItem(child: Text('Paytm Gateway'), value: 'PTMG'));
    listType.add(DropdownMenuItem(child: Text('Cash'), value: 'C'));
    listType.add(DropdownMenuItem(child: Text('Online'), value: 'O'));
  }

  Widget _alerttransaction(
      BuildContext context,
      double totalAmount,
      List<DropdownMenuItem<String>> listMode,
      List<DropdownMenuItem<String>> listType) {
    String selectedMode = null;
    String selectedType = null;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35.0),
                  bottomLeft: Radius.circular(35.0))),
          title: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Add Transaction",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                    fontFamily: 'Avenir-Bold',
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Do you want to add a transaction ?",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                      fontFamily: 'Avenir-Bold',
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: 'Amount: ',
                  style: TextStyle(
                      fontFamily: 'Avenir-Bold',
                      fontSize: 20.0,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: '$totalAmount',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Avenir-Black',
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500])),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Text('Payment Mode: '),
                  DropdownButton(
                    elevation: 4,
                    items: listMode,
                    hint: Text('Select Mode'),
                    onChanged: (String value) {
                      setState(() {
                        selectedMode = value;
                      });
                    },
                    isExpanded: false,
                    value: selectedMode,
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Payment Type: '),
                  DropdownButton(
                    elevation: 4,
                    value: selectedType,
                    items: listType,
                    hint: Text('Select Type'),
                    onChanged: (String value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                    isExpanded: false,
                  )
                ],
              ),
              Center(
                child: RaisedButton(
                  disabledColor: Colors.red.shade200,
                  color: Colors.red,
                  disabledElevation: 0.0,
                  elevation: 3.0,
                  splashColor: Colors.red.shade200,
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                      fontFamily: 'Avenir-Bold',
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () => {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
