import 'package:chakh_le_admin/entity/order.dart';
import 'package:chakh_le_admin/pages/transaction_page.dart';
import 'package:chakh_le_admin/utils/basic_details_card.dart';
import 'package:chakh_le_admin/utils/suborder.dart';
import 'package:flutter/material.dart';

class ViewDetails extends StatefulWidget {
  final Order order;
  ViewDetails({this.order});

  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('View Details'),
          bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                tabs: [
                  Tab(text: 'Basic Information'),
                  Tab(text: 'SubOrders'),
                  Tab(text: 'Transaction'),
                ],
              ),
            ),
            preferredSize: Size(0.0, 50),
          ),
        ),
        body: TabBarView(
          children: [
            Container(
                  child: basicDetailsCard(widget.order)
            ),
            Container(
              child: ListView.builder(
                itemCount: widget.order.suborderSet.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubOrderCard(context,widget.order, index);
                },
              ),
            ),
            TransactionPage()
          ],
        ),
      ),
    );
  }
}
