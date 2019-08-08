import 'package:chakh_le_admin/entity/employee.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:chakh_le_admin/utils/color_loader.dart';
import 'package:flutter/material.dart';

class AssignDeliveryBoyPage extends StatefulWidget {
  @override
  _AssignDeliveryBoyPageState createState() => _AssignDeliveryBoyPageState();
}

class _AssignDeliveryBoyPageState extends State<AssignDeliveryBoyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: ConstantVariables.deliveryBoyCount,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Text(ConstantVariables.deliveryBoyList[index].name),
            );
          },
        ),
      ),
    );
  }
}
