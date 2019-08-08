import 'dart:io';

import 'package:chakh_le_admin/entity/api_static.dart';
import 'package:chakh_le_admin/entity/order.dart';
import 'package:chakh_le_admin/entity/transaction_post.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class TransactionPostPage extends StatefulWidget {
  final Order order;

  TransactionPostPage({@required this.order});

  @override
  _TransactionPostPageState createState() => _TransactionPostPageState();
}

class _TransactionPostPageState extends State<TransactionPostPage> {
  String selectedMode;
  String selectedType;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Transaction Post') ,
        leading: new IconButton(
          icon: new Icon(Icons.close,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _transaction(context, widget.order.total),
    );
  }

  Widget _transaction(BuildContext context, double totalAmount) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
            child: Center(
              child: Text(
                "Add Transaction",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25.0,
                  fontFamily: 'Avenir-Bold',
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
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
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Padding(
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
                    "value": "COD",
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
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Padding(
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
                    "display": "Cash",
                    "value": "C",
                  },
                  {
                    "display": "Paytm",
                    "value": "PTM",
                  },
                  {
                    "display": "Google Pay",
                    "value": "GP",
                  },
                ],
                textField: 'display',
                valueField: 'value',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
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
                  onPressed: () {
                    Navigator.of(context).pop();
                    checkoutTransaction();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<http.Response> createPost(PostTransaction post) async {
    final response = await http.post(TransactionStatic.transactionCreateURL,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: postTransactionToJson(post));

    return response;
  }

  checkoutTransaction() {
    PostTransaction post = PostTransaction(
        order: widget.order.id,
        amount: widget.order.total.toString(),
        isCredit: true,
        paymentType: selectedType,
        paymentMode: selectedMode,
        acceptedBy: widget.order.deliveryBoy["delivery_boy"]);

    createPost(post).then((response) {
      if (response.statusCode == 201) {
        patchOrder(
            widget.order.id,
            ConstantVariables.orderCode[ConstantVariables.order[
                ConstantVariables.order.indexOf(widget.order.status) + 1]]);
        Fluttertoast.showToast(
          msg: "Transaction Completed",
          fontSize: 13.0,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIos: 2,
        );
      } else if (response.statusCode == 400) {
        // print(response.body);
      }
    }).catchError((Object error) {
      Fluttertoast.showToast(
        msg: "Please check your internet!",
        fontSize: 13.0,
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIos: 2,
      );
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        fontSize: 13.0,
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIos: 2,
      );
    });
  }
}
