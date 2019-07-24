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
              Tab(text: 'Out For Delivery'),
              Tab(text: 'Delivered'),
              Tab(text: 'Cancelled'),
            ],
            indicatorColor: Colors.white,
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: [
            Text('Pending'),
            Text('Accepted'),
            Text('Preparing'),
            Text('Ready'),
            Text('Out For Delivery'),
            Text('Delivered'),
            Text('Cancelled'),
          ],
        ),
      ),
    );
  }
}
