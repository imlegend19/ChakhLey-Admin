import 'dart:async';

import 'package:chakh_le_admin/entity/order.dart';
import 'package:chakh_le_admin/pages/add_order.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:chakh_le_admin/utils/color_loader.dart';
import 'package:chakh_le_admin/utils/order_card.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();

  final String status;

  OrderPage({@required this.status});
}

class _OrderPageState extends State<OrderPage> {
  StreamController _orderController;

  loadOrders() async {
    fetchOrder(widget.status).then((res) async {
      _orderController.add(res);
      return res;
    });
  }

  @override
  void initState() {
    super.initState();
    _orderController = StreamController();
    Timer.periodic(Duration(seconds: 3), (_) => loadOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (widget.status == "N")
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddOrderPage()));}
            )
          : null,
      body: StreamBuilder(
        stream: _orderController.stream,
        builder: (context, response) {
          if (response.hasData) {
            if (response.data.count != 0) {
              return ListView.builder(
                itemCount: response.data.count,
                itemBuilder: (BuildContext context, int index) {
                  return orderCard(context, response.data.orders[index]);
                },
              );
            } else {
              return Center(
                child: Container(
                    child: Text(
                  'No ${ConstantVariables.codeOrder[widget.status]} Orders Yet',
                  style: TextStyle(fontSize: 30.0),
                )),
              );
            }
          } else {
            return Container(
              child: Center(child: ColorLoader()),
            );
          }
        },
      ),
    );
  }
}
