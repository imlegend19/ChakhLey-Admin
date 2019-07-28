import 'package:chakh_le_admin/entity/order.dart';
import 'package:chakh_le_admin/entity/transaction.dart';
import 'package:chakh_le_admin/utils/transaction_saved_card.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();

  final Order order;
  final Future<GetTransactions> transaction;

  TransactionPage({@required this.transaction,@required this.order});
}

class _TransactionPageState extends State<TransactionPage> {
  String selectedMode;
  String selectedType;
  String selectedModeResult;
  String selectedTypeResult;

  bool isVisible = false;
  @override
  void initState() {
    super.initState();

    selectedMode = '';
    selectedType = '';
    selectedModeResult = '';
    selectedTypeResult = '';

    paymentDoneCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: isVisible,
        child: FloatingActionButton(
          onPressed: () =>
              _alertTransaction(context, 1000, selectedMode, selectedType),
          child: Icon(Icons.add),
        ),
      ),
      body: FutureBuilder<GetTransactions>(
          future: widget.transaction,
          builder: (context, response) {
            if (response.hasData) {
              return ListView.builder(
                itemCount: response.data.count,
                itemBuilder: (BuildContext context, int index) {
                  return transactionCard(
                      context, response.data.transactions[index]);
                },
              );
            } else {
              return Container();
            }
          }),
    );
  }

  _alertTransaction(BuildContext context, double totalAmount,
      String selectedMode, String selectedType) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35.0),
                  bottomLeft: Radius.circular(35.0))),
          title: Center(
            child: Text(
              "Add Transaction",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                fontFamily: 'Avenir-Bold',
                color: Colors.black,
              ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownFormField(
                  titleText: 'Payment Type',
                  hintText: 'Please choose one',
                  value: selectedType,
                  onSaved: (value) {
                    setState(() {
                      selectedType = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                    });
                  },
                  dataSource: [
                    {
                      "display": "Cash",
                      "value": "C",
                    },
                    {
                      "display": "Online",
                      "value": "O",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownFormField(
                  titleText: 'Payment Mode',
                  hintText: 'Please choose one',
                  value: selectedMode,
                  onSaved: (value) {
                    setState(() {
                      selectedMode = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedMode = value;
                    });
                  },
                  dataSource: [
                    {
                      "display": "Credit Card",
                      "value": "CC",
                    },
                    {
                      "display": "Debit Card",
                      "value": "DC",
                    },
                    {
                      "display": "Cash",
                      "value": "C",
                    },
                    {
                      "display": "INSTAMOJO",
                      "value": "IMJ",
                    },
                    {
                      "display": "Paytm",
                      "value": "PTM",
                    },
                    {
                      "display": "Paytm Gateway",
                      "value": "PTMG",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
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
                  onPressed: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void paymentDoneCheck(){
    if(widget.order.paymentDone == true){
      isVisible = false;
    }
    else{
      isVisible =true;
    }
  }
}
