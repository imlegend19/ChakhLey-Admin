import 'package:chakh_le_admin/entity/api_static.dart';
import 'package:chakh_le_admin/entity/order.dart';
import 'package:flutter/material.dart';

Widget basicDetailsCard(Order order){
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          RichText(
            text: TextSpan(
              text: 'Address: ',
              style: TextStyle(
                  fontFamily: 'Avenir-Bold',
                  fontSize: 20.0,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: '${order.delivery[RestaurantStatic.keyFullAddress]}',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Avenir-Black',
                        fontWeight: FontWeight.w500,color: Colors.grey[500])),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Restaurant: ',
              style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 18.0,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: '${order.restaurant[APIStatic.keyName]}',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Avenir-Black',
                        fontWeight: FontWeight.w500,color: Colors.grey[500])),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Name: ',
              style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 18.0,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: '${order.name}',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Avenir-Black',
                        fontWeight: FontWeight.w500,color: Colors.grey[500])),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Email: ',
              style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 18.0,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: '${order.email}',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Avenir-Black',
                        fontWeight: FontWeight.w500,color: Colors.grey[500])),
              ],
            ),
          ),
        ],
      ),
    )
  );
}