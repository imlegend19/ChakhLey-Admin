import 'package:chakh_le_admin/pages/restaurant_close.dart';
import 'package:chakh_le_admin/utils/color_loader.dart';
import 'package:flutter/material.dart';

import 'delivery_boy_service.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  dynamic body = _buildLoadingScreen();

  @override
  void initState() {
    super.initState();
    setState(() {
      body = TabBarView(children: [RestaurantPage(), DeliveryServicePage()]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: TabBar(
              tabs: [
                Tab(
                  text: 'Restaurant',
                ),
                Tab(
                  text: 'Delivery Boys',
                )
              ],
              isScrollable: true,
              indicatorColor: Colors.white,
            ),
          ),
          body: body,
        ));
  }
  static Widget _buildLoadingScreen() {
    return Container(
      child: Center(
        child: ColorLoader(),
      ),
    );
  }
}


