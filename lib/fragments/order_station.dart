import 'package:chakh_le_admin/pages/order_page.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:chakh_le_admin/utils/color_loader.dart';
import 'package:flutter/material.dart';

class OrderStation extends StatefulWidget {
  @override
  _OrderStationState createState() => _OrderStationState();
}

class _OrderStationState extends State<OrderStation> {
  dynamic body = _buildLoadingScreen();

  @override
  void initState() {
    super.initState();

    setState(() {
      body = TabBarView(
        children: [
          OrderPage(status: "N"),
          OrderPage(status: "Ac"),
          OrderPage(status: "Pr"),
          OrderPage(status: "O")
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          actions: <Widget>[],
          title: Center(
            child: TabBar(
              tabs: [
                Tab(text: 'New'),
                Tab(text: 'Accepted'),
                Tab(text: 'Preparing'),
                Tab(text: "On It's Way"),
              ],
              indicatorColor: Colors.white,
              isScrollable: true,
            ),
          ),
        ),
        body: body,
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
