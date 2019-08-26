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
  final Map<String, dynamic> acceptedBy;

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

  GetTransactions({this.transactions, this.count});

  factory GetTransactions.fromJson(Map<String, dynamic> response) {
    List<Transaction> transactions = [];
    int count = response[APIStatic.keyCount];

    List<dynamic> results = response[APIStatic.keyResult];

    for (int i = 0; i < results.length; i++) {
      Map<String, dynamic> jsonTransaction = results[i];
      transactions.add(
        Transaction(
          id: jsonTransaction[APIStatic.keyID],
          order: jsonTransaction[TransactionStatic.keyOrder],
          amount: jsonTransaction[TransactionStatic.keyAmount],
          isCredit: jsonTransaction[TransactionStatic.keyIsCredit],
          paymentType: jsonTransaction[TransactionStatic.keyPaymentType],
          paymentMode: jsonTransaction[TransactionStatic.keyPaymentMode],
          acceptedBy: jsonTransaction[TransactionStatic.keyAcceptedBy],
        ),
      );
    }

    count = transactions.length;

    return GetTransactions(transactions: transactions, count: count);
  }
}

Future<GetTransactions> fetchTransactions(String orderID) async {
  final response = await http.get(TransactionStatic.transactionURL + orderID);

  if (response.statusCode == 200) {
    int count = jsonDecode(response.body)[APIStatic.keyCount];
    int execute = count ~/ 10 + 1;

    GetTransactions transactions =
        GetTransactions.fromJson(jsonDecode(response.body));
    execute--;

    while (execute != 0) {
      GetTransactions tempOrder = GetTransactions.fromJson(jsonDecode(
          (await http.get(jsonDecode(response.body)[APIStatic.keyNext])).body));
      transactions.transactions += tempOrder.transactions;
      transactions.count += tempOrder.count;
      execute--;
    }

    return transactions;
  } else {
    return null;
  }
}
