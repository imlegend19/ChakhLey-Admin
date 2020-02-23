import 'package:chakh_le_admin/entity/employee.dart';
import 'package:chakh_le_admin/entity/order.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:flutter/material.dart';

class DeliveryServicePage extends StatefulWidget {
  @override
  _DeliveryServicePageState createState() => _DeliveryServicePageState();
}

class _DeliveryServicePageState extends State<DeliveryServicePage> {
  List<Employee> deliveryBoyList = [];
  List<dynamic> orderStatusList = [];
  List<bool> _value = List<bool>.filled(ConstantVariables.deliveryBoyCount, false, growable: true);

  @override
  void initState() {
    super.initState();
    if (ConstantVariables.deliveryBoyList != null) {
      int it = 0;
      for (final i in ConstantVariables.deliveryBoyList) {
        deliveryBoyList.add(i);
        _value[it] = i.isActive;
        it += 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: deliveryBoyList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${deliveryBoyList[index].userName}'),
            leading: Switch(
                inactiveThumbColor: Colors.red,
                activeColor: Colors.green,
                value: _value[index],
                onChanged: (value) {
                  setState(() {
                    _value[index] = value;
                    patchOrderDeliveryBoy(index, deliveryBoyList[index].userId,_value[index]);
                    print("index : $index, deliveryBoy : ${ConstantVariables.deliveryBoy}, deliveryBoy Name : ${deliveryBoyList[index].userName}, isActive : ${_value[index]}");
                  });
                }),
          );
        },
      ),
    );
  }
}