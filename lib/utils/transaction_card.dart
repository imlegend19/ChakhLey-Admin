import 'package:flutter/material.dart';

Widget TransactionCard(
    double totalAmount,
    List<DropdownMenuItem<String>> listMode,
    List<DropdownMenuItem<String>> listType,
    List<DropdownMenuItem<String>> listAcceptedBy) {
  String selectedMode = null;
  String selectedType = null;
  String selectedAcceptedBy = null;
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: RichText(
              text: TextSpan(
                text: 'Amount: ',
                style: TextStyle(
                    fontFamily: 'Avenir-Bold',
                    fontSize: 20.0,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: '$totalAmount',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Avenir-Black',
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[500])),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: <Widget>[
                Text('Payment Mode: '),
                DropdownButton(
                  elevation: 4,
                  value: selectedMode,
                  items: listMode,
                  hint: Text('Select Mode'),
                  onChanged: (value) {
                    selectedMode = value;
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: <Widget>[
                Text('Payment Type: '),
                DropdownButton(
                  elevation: 4,
                  value: selectedType,
                  items: listType,
                  hint: Text('Select Type'),
                  onChanged: (value) {
                    selectedType = value;
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: <Widget>[
                Text('AcceptedBy: '),
                DropdownButton(
                  elevation: 4,
                  value: selectedAcceptedBy,
                  items: listAcceptedBy,
                  hint: Text('Select Delivery Boy'),
                  onChanged: (value) {
                    selectedAcceptedBy = value;
                  },
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
