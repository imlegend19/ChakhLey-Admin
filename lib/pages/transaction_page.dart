import 'dart:io';

import 'package:chakh_le_admin/entity/api_static.dart';
import 'package:chakh_le_admin/entity/employee.dart';
import 'package:chakh_le_admin/entity/order.dart';
import 'package:chakh_le_admin/entity/transaction.dart';
import 'package:chakh_le_admin/entity/transaction_post.dart';
import 'package:chakh_le_admin/fragments/order_station.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:chakh_le_admin/utils/transaction_saved_card.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();

  final Order order;
  final Future<GetTransactions> transaction;
  final Future<GetEmployees> employees;

  TransactionPage(
      {@required this.transaction,
      @required this.order,
      @required this.employees});
}

class _TransactionPageState extends State<TransactionPage> {
  String selectedMode;
  String selectedType;
  int selectedDeliveryBoy;
  bool isVisible = false;
  List deliveryBoys = [];

  @override
  void initState() {
    super.initState();
    paymentDoneCheck();

    for (final i in ConstantVariables.deliveryBoyList) {
      deliveryBoys.add({
        "display": i.name,
        "value": i.id,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: isVisible,
        child: FloatingActionButton(
          onPressed: () => _alertTransaction(context, widget.order.total),
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

  _alertTransaction(BuildContext context, double totalAmount) {
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
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropDownFormField(
                    titleText: 'Delivery Boy',
                    hintText: 'Please choose one',
                    value: selectedDeliveryBoy,
                    onSaved: (value) {
                      setState(() {
                        selectedDeliveryBoy = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        selectedDeliveryBoy = value;
                      });
                    },
                    dataSource: deliveryBoys,
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
                    onPressed: () {
                      Navigator.of(context).pop();
                      checkoutTransaction();
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return OrderStation();
                      }));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void paymentDoneCheck() {
    if (widget.order.paymentDone == true) {
      isVisible = false;
    } else {
      isVisible = true;
    }
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
        acceptedBy: selectedDeliveryBoy);

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
