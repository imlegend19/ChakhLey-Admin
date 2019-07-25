import 'package:flutter/material.dart';

Widget orderCard(String name, String nextStatus,String orderId,double totalPrice,String payment) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$name',
                  style: TextStyle(fontFamily: 'Avenir', fontSize: 15.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Status',
                  style: TextStyle(
                      fontFamily: 'Avenir-Bold',
                      fontSize: 20.0,
                      color: Colors.red),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Order id: $orderId',
              style: TextStyle(fontFamily: 'Avenir', fontSize: 15.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total Price : $totalPrice',
              style: TextStyle(fontFamily: 'Avenir', fontSize: 15.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$payment ',
                  style: TextStyle(fontFamily: 'Avenir', fontSize: 15.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      child: Text(
                        'Call',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Avenir-Bold',
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.deepPurpleAccent,
                      onPressed: () {},
                      child: Text(
                        'Next: $nextStatus',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 14.0,
                            color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
}