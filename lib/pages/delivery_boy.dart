import 'package:chakh_le_admin/entity/api_static.dart';
import 'package:chakh_le_admin/entity/order.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:chakh_le_admin/utils/color_loader.dart';
import 'package:chakh_le_admin/utils/delivery_boy_card.dart';
import 'package:flutter/material.dart';

class DeliveryBoyPage extends StatefulWidget {
  @override
  _DeliveryBoyPageState createState() => _DeliveryBoyPageState();
}

class _DeliveryBoyPageState extends State<DeliveryBoyPage> {
  int selectedDeliveryBoy;
  String selectedStatus;
  List<DropdownMenuItem<int>> deliveryBoys = [];
  List<DropdownMenuItem<String>> orderStatusList = [];

  bool disableStatusDropdown = true;
  bool fetchNow = false;

  @override
  void initState() {
    super.initState();
    for (final i in ConstantVariables.deliveryBoyList) {
      deliveryBoys.add(DropdownMenuItem(
        value: i.id,
        child: Text(i.user[APIStatic.keyName]),
      ));
    }
    orderStatusList.add(DropdownMenuItem(
      child: Text('Ongoing'),
      value: "O",
    ));
    orderStatusList.add(DropdownMenuItem(
      child: Text("Delivered"),
      value: 'D',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width, child: _deliveryBoy()),
        ],
      ),
    );
  }

  Widget _deliveryBoy() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                DropdownButton(
                  hint: Text(
                    "Delivery Boy",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  value: selectedDeliveryBoy,
                  onChanged: (newValue) {
                    setState(() {
                      selectedDeliveryBoy = newValue;
                      ConstantVariables.deliveryBoy = selectedDeliveryBoy;
                      if (selectedDeliveryBoy != null) {
                        setState(() {
                          disableStatusDropdown = false;
                        });
                      } else {
                        setState(() {
                          disableStatusDropdown = true;
                        });
                      }
                    });
                  },
                  items: deliveryBoys,
                ),
                DropdownButton(
                  hint: Text(
                    "Status",
                    textAlign: TextAlign.center,
                  ),
                  value: selectedStatus,
                  onChanged: disableStatusDropdown
                      ? null
                      : (newValue) {
                          setState(() {
                            selectedStatus = newValue;
                            fetchNow = true;
                          });
                        },
                  items: orderStatusList,
                ),
              ],
            ),
          ),
          fetchNow
              ? Container(
                  child: FutureBuilder<GetOrders>(
                    future: fetchOrderDeliveryBoy(
                        selectedStatus, selectedDeliveryBoy),
                    builder: (context, response) {
                      if (response.hasData) {
                        if (response.data.count != 0) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: ListView.builder(
                              itemCount: response.data.count,
                              itemBuilder: (BuildContext context, int index) {
                                return deliveryBoyCard(
                                    response.data.orders[index]);
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: Container(
                                child: Text(
                              'No ${ConstantVariables.codeOrder[selectedStatus]} Orders Yet',
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
                )
              : Container()
        ],
      ),
    );
  }
}
