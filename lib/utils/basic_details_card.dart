import 'package:chakh_le_admin/entity/api_static.dart';
import 'package:chakh_le_admin/entity/order.dart';
import 'package:flutter/material.dart';

Widget basicDetailsCard(Order order) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, left: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: RichText(
            text: TextSpan(
              text: 'Name: ',
              style: TextStyle(
                fontFamily: 'Avenir-Black',
                fontSize: 20.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '${order.name}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Avenir-Black',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: RichText(
            text: TextSpan(
              text: 'Email: ',
              style: TextStyle(
                fontFamily: 'Avenir-Black',
                fontSize: 20.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '${order.email}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Avenir-Black',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: RichText(
            text: TextSpan(
              text: 'Restaurant: ',
              style: TextStyle(
                fontFamily: 'Avenir-Black',
                fontSize: 20.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '${order.restaurant[APIStatic.keyName]}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Avenir-Bold',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: RichText(
            text: TextSpan(
              text: 'Address: ',
              style: TextStyle(
                fontFamily: 'Avenir-Black',
                fontSize: 20.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '${order.delivery[RestaurantStatic.keyFullAddress]}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Avenir-Bold',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: RichText(
            text: TextSpan(
              text: 'DeliveryBoy: ',
              style: TextStyle(
                fontFamily: 'Avenir-Black',
                fontSize: 20.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: order.deliveryBoy !=null ? '${order.deliveryBoy["user"]["name"]}': 'Not Assigned',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Avenir-Bold',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
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
