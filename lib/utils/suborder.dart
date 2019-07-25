import 'package:flutter/material.dart';

Widget SubOrderCard(BuildContext context, String productName,
    double individualAmount, int quantity, double subOrderAmount) {
  return Card(
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                '$productName',
                style: TextStyle(
                    fontFamily: 'Avenir-Bold',
                    fontSize: 20.0,
                    color: Colors.black),
              ),
              Text(
                '$individualAmount',
                style: TextStyle(
                  fontFamily: 'Avenir-Black',
                  fontSize: 14.0,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: 'Quantity: ',
                  style: TextStyle(
                      fontFamily: 'Avenir-Bold',
                      fontSize: 20.0,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: '$subOrderAmount',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Avenir-Black',
                            fontWeight: FontWeight.w500,color: Colors.grey[500])),
                  ],
                ),
              ),
              Text(
                '$subOrderAmount',
                style: TextStyle(fontFamily: 'Avenir-Black', fontSize: 20.0),
              )
            ],
          ),
        )
      ],
    ),
  );
}
