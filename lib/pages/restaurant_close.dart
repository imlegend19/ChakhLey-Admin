import 'package:chakh_le_admin/entity/restaurant.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:flutter/material.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  List<String> restaurantNameList = [];
  List<bool> _value = List<bool>.filled(15, true, growable: true);

  @override
  void initState() {
    super.initState();
    if (ConstantVariables.restaurantList != null) {
      for (final i in ConstantVariables.restaurantList) {
        restaurantNameList.add(i.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: restaurantNameList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${restaurantNameList[index]}'),
            leading: Switch(
              inactiveThumbColor: Colors.red,
                activeColor: Colors.green,
                value: _value[index],
                onChanged: (value) {
                  setState(() {
                    _value[index] = value;
                    patchRestaurantOpen(_value[index], index + 1);
                  });
                }),
          );
        },
      ),
    );
  }
}
