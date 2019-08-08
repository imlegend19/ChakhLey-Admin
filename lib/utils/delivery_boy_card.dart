import 'package:chakh_le_admin/entity/order.dart';
import 'package:flutter/material.dart';

Widget deliveryBoyCard(Order order) {
  return Card(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, top: 8.0, bottom: 5.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                '${order.name}',
                style: TextStyle(
                  fontFamily: 'Avenir-Black',
                  fontSize: 18.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${order.status}',
                style: TextStyle(
                  fontFamily: 'Avenir-Bold',
                  fontSize: 17.0,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'Avenir-Bold',
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Order ID: ',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
                TextSpan(
                  text: '#${order.id}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'Avenir-Bold',
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Total Price: ',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
                TextSpan(
                  text: '${order.total}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
