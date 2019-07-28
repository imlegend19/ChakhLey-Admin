import 'dart:convert';

import 'api_static.dart';

class PostTransaction {
  final int id;
  final int order;
  final String amount;
  final bool isCredit;
  final String paymentType;
  final String paymentMode;
  final int acceptedBy;

  PostTransaction({this.id,
    this.order,
    this.amount,
    this.isCredit,
    this.paymentType,
    this.paymentMode,
    this.acceptedBy});

  factory PostTransaction.fromJson(Map<String, dynamic> json) {
    return PostTransaction(
      id: json[APIStatic.keyID],
      order: json[TransactionStatic.keyOrder],
      amount: json[TransactionStatic.keyAmount],
      isCredit: json[TransactionStatic.keyIsCredit],
      paymentType: json[TransactionStatic.keyPaymentType],
      paymentMode: json[TransactionStatic.keyPaymentMode],
      acceptedBy: json[TransactionStatic.keyAcceptedBy],
    );
  }
  Map<String, dynamic> toJson() =>
      {
        APIStatic.keyID:id,
        TransactionStatic.keyOrder:order,
        TransactionStatic.keyAmount:amount,
        TransactionStatic.keyIsCredit:isCredit,
        TransactionStatic.keyPaymentType:paymentType,
        TransactionStatic.keyPaymentMode:paymentType,
        TransactionStatic.keyAcceptedBy:acceptedBy
      };
}

String postTransactionToJson(PostTransaction data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}