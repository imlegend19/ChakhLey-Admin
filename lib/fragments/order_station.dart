import 'dart:async';

import 'package:chakh_le_admin/entity/order.dart';
import 'package:chakh_le_admin/pages/order_page.dart';
import 'package:chakh_le_admin/utils/color_loader.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class OrderStation extends StatefulWidget {
  @override
  _OrderStationState createState() => _OrderStationState();
}

class _OrderStationState extends State<OrderStation> {
  var _connectionStatus;
  Connectivity connectivity;

  StreamSubscription<ConnectivityResult> subscription;
  dynamic body = _buildLoadingScreen();

  @override
  void initState() {
    super.initState();
    connectivity = Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result;
      if (result == ConnectivityResult.none) {
        setState(() {
          body = _buildNoInternet();
        });
      } else if ((result == ConnectivityResult.mobile) ||
          (result == ConnectivityResult.wifi)) {
        setState(() {
          body = TabBarView(
            children: [
              OrderPage(status: "Pending", order: fetchOrder("Pe")),
              OrderPage(status: "Accepted", order: fetchOrder("Ac")),
              OrderPage(status: "Preparing", order: fetchOrder("Pr")),
              OrderPage(status: "Ready", order: fetchOrder("R")),
              OrderPage(status: "Dispatched", order: fetchOrder("Di")),
              OrderPage(status: "Delivery", order: fetchOrder("D")),
              OrderPage(status: "Cancelled", order: fetchOrder("C")),
            ],
          );
        });
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          actions: <Widget>[],
          title: TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Accepted'),
              Tab(text: 'Preparing'),
              Tab(text: 'Ready'),
              Tab(text: 'Dispatched'),
              Tab(text: 'Delivered'),
              Tab(text: 'Cancelled'),
            ],
            indicatorColor: Colors.white,
            isScrollable: true,
          ),
        ),
        body: body,
      ),
    );
  }

  Widget _buildNoInternet() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 60.0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Transform.translate(
              child:
                  Image(image: AssetImage('assets/no_internet_connection.gif')),
              offset: Offset(0, -50),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Transform.translate(
              offset: Offset(0, -50),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'No connection',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Avenir-Black',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Transform.translate(
              offset: Offset(0, -40),
              child: Text(
                'Please check your internet connection and try again.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Avenir-Bold',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildLoadingScreen() {
    return Container(
      child: Center(
        child: ColorLoader(),
      ),
    );
  }
}
