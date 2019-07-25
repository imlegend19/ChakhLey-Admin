import 'package:chakh_le_admin/pages/view_details_page.dart';
import 'package:flutter/material.dart';

class ViewDetails extends StatefulWidget {
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
            Text('Basic Information'),
            ViewDetailsPage(),
            Text('Transaction')
          ],
        ),
      ),
    );
  }
}
