import 'package:chakh_le_admin/entity/order.dart';
import 'package:chakh_le_admin/pages/order_page.dart';
import 'package:flutter/material.dart';

class OrderStation extends StatefulWidget {
  @override
  _OrderStationState createState() => _OrderStationState();
}

class _OrderStationState extends State<OrderStation> {
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
        body: TabBarView(
          children: [
            OrderPage(status: "Pending", order: fetchOrder("Pe")),
            OrderPage(status: "Accepted", order: fetchOrder("Ac")),
            OrderPage(status: "Preparing", order: fetchOrder("Pr")),
            OrderPage(status: "Ready", order: fetchOrder("R")),
            OrderPage(status: "Dispatched", order: fetchOrder("Di")),
            OrderPage(status: "Delivery", order: fetchOrder("D")),
            OrderPage(status: "Cancelled", order: fetchOrder("C")),
          ],
        ),
      ),
    );
  }
}
