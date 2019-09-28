import 'dart:async';

import 'package:chakh_le_admin/entity/order.dart';
import 'package:chakh_le_admin/models/notification_helper.dart';
import 'package:chakh_le_admin/pages/add_order.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:chakh_le_admin/utils/color_loader.dart';
import 'package:chakh_le_admin/utils/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();

  final String status;

  OrderPage({@required this.status});
}

class _OrderPageState extends State<OrderPage> {
  StreamController _orderController;
  final notifications = FlutterLocalNotificationsPlugin();

  loadOrders() async {
    Future.sync(() {
      fetchOrder(widget.status).then((res) async {
        _orderController.add(res);

        return res;
      }).catchError((error) {
        _orderController = StreamController();
        loadOrders();
      });
    }).catchError((error) {
      _orderController = StreamController();
      loadOrders();
    });
  }

  @override
  void initState() {
    super.initState();
    _orderController = StreamController();
    Timer.periodic(Duration(seconds: 3), (_) => loadOrders());

    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingIOS = IOSInitializationSettings();

    notifications
        .initialize(InitializationSettings(settingsAndroid, settingIOS));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (widget.status == "N")
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddOrderPage()));
              })
          : null,
      body: StreamBuilder(
          stream: _orderController.stream,
          builder: (context, response) {
            if (response.data != null) {
              if (response.hasData) {
                if (response.data.count != 0) {
                  for (int i = 0; i < response.data.orders.length; i++) {
                    if (!ConstantVariables.newOrders
                        .contains(response.data.orders[i].id)) {
                      ConstantVariables.newOrders
                          .add(response.data.orders[i].id);

                      // TODO: Send Notification
                      showOngoingNotification(notifications,
                          title: 'Order Id: ${response.data.orders[i].id}',
                          body: 'You have received a new order.');
                    }
                  }

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: response.data.count,
                      itemBuilder: (BuildContext context, int index) {
                        return orderCard(context, response.data.orders[index]);
                      },
                    ),
                  );
                } else {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'No ${ConstantVariables.codeOrder[widget.status]} Orders Yet',
                          style: TextStyle(fontSize: 25.0),
                          maxLines: 3,
                        ),
                      ),
                    ),
                  );
                }
              } else {
                return getErrorWidget(context);
              }
            } else {
              return Container(
                child: Center(child: ColorLoader()),
              );
            }
          }),
    );
  }

  Widget getErrorWidget(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xfff1f2f6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Image(
                image: AssetImage('assets/error.png'),
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
            Text(
              "OOPS",
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Avenir',
                fontWeight: FontWeight.w400,
                fontSize: 15.0,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.84,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Sorry, something went wrong! A team of highly trained monkeys "
                "has been dispatched to deal with this situation.",
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade500,
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
