import 'package:chakh_le_admin/entity/api_static.dart';
import 'package:chakh_le_admin/entity/order.dart';
import 'package:flutter/material.dart';

Widget subOrderCard(BuildContext context, Order order, int index) {
  return Padding(
    padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
    child: Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 5.0, bottom: 3.0, left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    '${order.suborderSet[index][SuborderSetStatic.keyProduct][APIStatic.keyName]}',
                    style: TextStyle(
                      fontFamily: 'Avenir-Bold',
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '${order.suborderSet[index][SuborderSetStatic.keyProduct][SuborderSetStatic.keyPrice]}',
                    style: TextStyle(
                        fontFamily: 'Avenir-Black',
                        fontSize: 15.0,
                        color: Colors.grey.shade600),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 3.0, bottom: 5.0, left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Quantity: ',
                    style: TextStyle(
                      fontFamily: 'Avenir-Bold',
                      fontSize: 19.0,
                      color: Colors.black87,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '${order.suborderSet[index][SuborderSetStatic.keyQuantity]}',
                        style: TextStyle(
                          fontSize: 16.0,
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
                    text: 'Sub-Total: ',
                    style: TextStyle(
                      fontFamily: 'Avenir-Bold',
                      fontSize: 19.0,
                      color: Colors.black87,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '${order.suborderSet[index][SuborderSetStatic.keySubTotal]}',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'Avenir-Black',
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
