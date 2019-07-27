import 'package:chakh_le_admin/entity/api_static.dart';
import 'package:chakh_le_admin/entity/order.dart';
import 'package:flutter/material.dart';

Widget SubOrderCard(BuildContext context, Order order, int index) {
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
                '${order.suborderSet[index][SuborderSetStatic.keyProduct][APIStatic.keyName]}',
                style: TextStyle(
                    fontFamily: 'Avenir-Bold',
                    fontSize: 20.0,
                    color: Colors.black),
              ),
              Text(
                '${order.suborderSet[index][SuborderSetStatic.keyProduct][SuborderSetStatic.keyPrice]}',
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
                        text: '${order.suborderSet[index][SuborderSetStatic.keyQuantity]}',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Avenir-Black',
                            fontWeight: FontWeight.w500,color: Colors.grey[500])),
                  ],
                ),
              ),
              Text(
                '${order.suborderSet[index][SuborderSetStatic.keySubTotal]}',
                style: TextStyle(fontFamily: 'Avenir-Black', fontSize: 20.0),
              )
            ],
          ),
        )
      ],
    ),
  );
}
