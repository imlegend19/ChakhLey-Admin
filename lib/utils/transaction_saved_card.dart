import 'package:chakh_le_admin/entity/transaction.dart';
import 'package:flutter/material.dart';

Widget transactionCard(BuildContext context, Transaction transaction) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    text: '${transaction.amount}',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Avenir-Black',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500])),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Payment Mode: ',
              style: TextStyle(
                  fontFamily: 'Avenir-Bold',
                  fontSize: 20.0,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: '${transaction.paymentMode}',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Avenir-Black',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500])),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Payment Type: ',
              style: TextStyle(
                  fontFamily: 'Avenir-Bold',
                  fontSize: 20.0,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: '${transaction.paymentType}',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Avenir-Black',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Accepted By: ',
              style: TextStyle(
                fontFamily: 'Avenir-Bold',
                fontSize: 20.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '${transaction.acceptedBy}',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Avenir-Black',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
