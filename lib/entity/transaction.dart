import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_static.dart';

class Transaction {
  final int id;
  final int order;
  final String amount;
  final bool isCredit;
  final String paymentType;
  final String paymentMode;
  final int acceptedBy;

  Transaction(
      {this.id,
      this.order,
      this.amount,
      this.isCredit,
      this.paymentType,
      this.paymentMode,
      this.acceptedBy});
}

class GetTransactions {
  List<Transaction> transactions;
  int count;

  GetTransactions({this.transactions,this.count});

  factory GetTransactions.fromJson(Map<String,dynamic> response){
    List<Transaction> transactions = [];
    int count = response[APIStatic.keyCount];

    List<dynamic> results = response[APIStatic.keyResult];

    for (int i = 0; i < results.length; i++) {
      Map<String, dynamic> jsonOrder = results[i];
      transactions.add(
        Transaction(
          id: jsonOrder[APIStatic.keyID],
        ),
      );
    }
  }

}
