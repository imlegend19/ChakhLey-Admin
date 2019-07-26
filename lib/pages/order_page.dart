import 'package:chakh_le_admin/entity/order.dart';
import 'package:chakh_le_admin/utils/order_card.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();

  final String status;
  final Future<GetOrders> order;

  OrderPage({@required this.order, @required this.status});
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GetOrders>(
        future: widget.order,
        builder: (context, response) {
          if (response.hasData) {
            return ListView.builder(
              itemCount: response.data.count,
              itemBuilder: (BuildContext context, int index) {
                return orderCard(context, response.data.orders[index]);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
