import 'package:chakh_le_admin/fragments/order_station.dart';
import 'package:chakh_le_admin/models/user_pref.dart';
import 'package:chakh_le_admin/pages/deliveryboy.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:flutter/material.dart';

import 'entity/employee.dart';
import 'entity/order.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {

  final Order order;

  HomePage({@required this.order});

  final drawerItems = [
    DrawerItem("Order Station", Icons.local_dining),
    DrawerItem("Delivery Boys", Icons.motorcycle),
    DrawerItem("Logout", Icons.power_settings_new)
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchEmployee().then((value) {
      setState(() {
        ConstantVariables.deliveryBoyList = value.employees;
        ConstantVariables.deliveryBoyCount = value.count;
      });
    });
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return OrderStation();
      case 1:
        return Container(
          child: DeliveryBoyPage(),
        );
      case 2:
        logoutUser().then((val) {
          Navigator.pushReplacementNamed(context, '/loginpage');
        });
        break;
      default:
        return Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      if (d.title == "Logout") {
        drawerOptions.add(
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Container(
              width: 200,
              child: Divider(
                color: Colors.grey,
                height: 2.0,
              ),
            ),
          ),
        );
      }
      drawerOptions.add(ListTile(
        leading: Icon(d.icon),
        title: Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(icon: Icon(Icons.dehaze), onPressed: () => _scaffoldKey.currentState.openDrawer()),
            Text(widget.drawerItems[_selectedDrawerIndex].title),
          ],
        ),
        titleSpacing: 1,
        automaticallyImplyLeading: false,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey[200],
              ),
                accountName: Text(ConstantVariables.user['name']),
                accountEmail: Text(ConstantVariables.user['email'])),
            Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
