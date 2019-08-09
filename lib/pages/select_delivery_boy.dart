import 'package:chakh_le_admin/entity/order.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:flutter/material.dart';

class SelectDeliveryBoyPage extends StatefulWidget {
  final Order order;

  SelectDeliveryBoyPage({@required this.order});
  @override
  _SelectDeliveryBoyPageState createState() => _SelectDeliveryBoyPageState();
}

class _SelectDeliveryBoyPageState extends State<SelectDeliveryBoyPage> {
  int _currentIndex;
  List<GroupModel> _deliveryBoyNameList = [];

  @override
  void initState() {
    super.initState();
    for (final i in ConstantVariables.deliveryBoyList) {
      _deliveryBoyNameList.add(GroupModel(text: i.name, index: i.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Delivery Boy'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(
              height: 350.0,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: _deliveryBoyNameList
                    .map((t) => RadioListTile(
                          title: Text("${t.text}"),
                          groupValue: _currentIndex,
                          value: t.index,
                          onChanged: (val) {
                            setState(() {
                              _currentIndex = val;
                            });
                          },
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: RaisedButton(
                color: Colors.deepPurpleAccent,
                disabledColor: Colors.redAccent,
                onPressed: (_currentIndex == null)
                    ? null
                    : () {
                        patchOrderDeliveryBoy(
                            widget.order.id, ConstantVariables.orderCode[ConstantVariables
                            .order[ConstantVariables.order.indexOf(widget.order.status) + 1]], _currentIndex);
                        Navigator.pop(context);
                      },
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GroupModel {
  String text;
  int index;
  GroupModel({this.text, this.index});
}
