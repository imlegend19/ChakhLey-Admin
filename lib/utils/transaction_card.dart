import 'package:flutter/material.dart';

Widget TransactionCard(double totalAmount,String mode,String type,String name){
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
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
                          fontWeight: FontWeight.w500,color: Colors.grey[500])),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: RichText(
              text: TextSpan(
                text: 'Payment Mode: ',
                style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 20.0,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: '$mode',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Avenir-Black',
                          fontWeight: FontWeight.w500,color: Colors.grey[500])),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: RichText(
              text: TextSpan(
                text: 'Payment Type: ',
                style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 20.0,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: '$type',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Avenir-Black',
                          fontWeight: FontWeight.w500,color: Colors.grey[500])),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: RichText(
              text: TextSpan(
                text: 'Accepted By: ',
                style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 20.0,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: '$name',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Avenir-Black',
                          fontWeight: FontWeight.w500,color: Colors.grey[500])),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
