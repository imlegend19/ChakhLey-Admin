import 'package:chakh_le_admin/entity/restaurant.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:flutter/material.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  List<Restaurant> restaurantList = [];
  List<bool> _value = List<bool>.filled(16, false, growable: true);

  @override
  void initState() {
    super.initState();
    if (ConstantVariables.restaurantList != null) {
      int it = 0;
      for (final i in ConstantVariables.restaurantList) {
        restaurantList.add(i);
        _value[it] = i.isActive;
        it += 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: restaurantList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${restaurantList[index].name}'),
            leading: Switch(
                inactiveThumbColor: Colors.red,
                activeColor: Colors.green,
                value: _value[index],
                onChanged: (value) {
                  setState(() {
                    _value[index] = value;
                    patchRestaurantOpen(
                        _value[index], restaurantList[index].id);
                  });
                }),
          );
        },
      ),
    );
  }
}
