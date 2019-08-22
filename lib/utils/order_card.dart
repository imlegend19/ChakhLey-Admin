import 'package:chakh_le_admin/entity/order.dart';
import 'package:chakh_le_admin/fragments/view_details.dart';
import 'package:chakh_le_admin/pages/select_delivery_boy.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget orderCard(BuildContext context, Order order) {
  return Card(
    child: InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewDetails(order: order)));
      },
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
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    (order.paymentDone == false) ? "Unpaid" : "Paid",
                    style: TextStyle(
                      fontFamily: 'Avenir-Bold',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: (order.paymentDone == false)
                          ? Colors.red
                          : Colors.green.shade500,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: 80,
                        child: FlatButton(
                          child: Text(
                            'Call',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Avenir-Bold',
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          onPressed: () {
                            launch("tel://+91 ${order.mobile}");
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: RaisedButton(
                        color: Colors.deepPurpleAccent,
                        disabledColor:
                            (ConstantVariables.order.indexOf(order.status) == 4)
                                ? Colors.green
                                : Colors.redAccent,
                        onPressed: () {
                          orderStatusButton(context, order);
                        },
                        child: Text(
                          checkStatusText(order),
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

String checkStatusText(Order order) {
  if (ConstantVariables.order.indexOf(order.status) == 4) {
    return 'Completed';
  } else if (ConstantVariables.order.indexOf(order.status) == 5) {
    return 'Cancelled';
  } else {
    return '${ConstantVariables.order[ConstantVariables.order.indexOf(order.status) + 1]}';
  }
}

void orderStatusButton(BuildContext context, Order order) {
  if ((ConstantVariables.order.indexOf(order.status) == 4 ||
      ConstantVariables.order.indexOf(order.status) == 5)) {
    return null;
  } else if (ConstantVariables.order.indexOf(order.status) == 1) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectDeliveryBoyPage(order: order)));
  } else {
    checkStatusOnPressed(order);
  }
}

void checkStatusOnPressed(Order order) {
  patchOrder(
      order.id,
      ConstantVariables.orderCode[ConstantVariables
          .order[ConstantVariables.order.indexOf(order.status) + 1]]);
}
