import 'package:chakh_le_admin/entity/employee.dart';
import 'package:chakh_le_admin/entity/order.dart';
import 'package:chakh_le_admin/entity/restaurant.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:flutter/material.dart';

class DeliveryServicePage extends StatefulWidget {
  @override
  _DeliveryServicePageState createState() => _DeliveryServicePageState();
}

class _DeliveryServicePageState extends State<DeliveryServicePage> {
  List<Order> deliveryBoyList = [];
  List<bool> _value = List<bool>.filled(7, false, growable: true);

  // @override
  // void initState() {
  //   super.initState();
  //   if (ConstantVariables.deliveryBoyList != null) {
  //     int it = 0;
  //     for (final i in ConstantVariables.deliveryBoyList) {
  //       deliveryBoyList.add(i);
  //       _value[it] = i.isActive;
  //       it += 1;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: deliveryBoyList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${deliveryBoyList[index].name}'),
            leading: Switch(
                inactiveThumbColor: Colors.red,
                activeColor: Colors.green,
                value: _value[index],
                onChanged: (value) {
                  setState(() {
                    // patchOrderDeliveryBoy(id, status, deliveryBoy)
                  });
                }),
          );
        },
      ),
    );
  }
}