import 'dart:io';
import 'dart:convert' as JSON;
import 'package:chakh_le_admin/entity/api_static.dart';
import 'package:chakh_le_admin/entity/order_post.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CheckoutPage extends StatefulWidget {
  final double total, deliveryFee;
  final String name, email, phone;
  final int restaurant;

  CheckoutPage({
    @required this.total,
    @required this.deliveryFee,
    this.email,
    this.name,
    this.phone,
    this.restaurant,
  });

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _unitNoController = TextEditingController();
  TextEditingController _landmarkController = TextEditingController();
  TextEditingController _ptController = TextEditingController(text: "35");

  Future<PostOrder> postOrder;

  bool enableProceed = false;
  String buttonText = "ENTER HOUSE / FLAT NO";

  List<Map<String, int>> suborderSet = List();

  @override
  void initState() {
    super.initState();
    _controller.addListener(validateText);
    _unitNoController.addListener(validateText);

    suborderSet = convertToMap();
  }

  @override
  void dispose() {
    _controller.dispose();
    _unitNoController.dispose();
    _landmarkController.dispose();
    _ptController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        textTheme: TextTheme(
          title: TextStyle(
            fontWeight: FontWeight.w300,
            color: Colors.white,
            fontFamily: 'Avenir-Black',
            fontSize: 18.0,
          ),
        ),
        titleSpacing: 2,
        title: Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: Text('Set delivery location'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 5.0),
              child: Container(
                color: Colors.grey[300],
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    labelText: 'Location',
                    labelStyle: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Avenir-Black',
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Avenir-Bold',
                    color: Colors.black87,
                  ),
                  controller: _controller,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  labelText: 'House / Flat No',
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'Avenir-Black',
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Avenir-Bold',
                  color: Colors.black87,
                ),
                cursorColor: Colors.red,
                controller: _unitNoController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  labelText: 'Landmark',
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'Avenir-Black',
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Avenir-Bold',
                  color: Colors.black87,
                ),
                cursorColor: Colors.red,
                controller: _landmarkController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 5.0, top: 1.0),
                    child: Icon(
                      Icons.report,
                      size: 13.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    'Cash on Delivery by default',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontFamily: "Avenir-Black",
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  labelText: 'Preparation Time',
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'Avenir-Black',
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Avenir-Bold',
                  color: Colors.black87,
                ),
                cursorColor: Colors.red,
                controller: _ptController,
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50.0,
                child: RaisedButton(
                  disabledColor: Colors.red.shade200,
                  color: Colors.redAccent,
                  disabledElevation: 0.0,
                  elevation: 3.0,
                  splashColor: Colors.red.shade200,
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.0,
                      color: Colors.white,
                      fontFamily: 'Avenir-Bold',
                    ),
                  ),
                  onPressed: enableProceed
                      ? () {
                          checkoutOrder();
                        }
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateText() {
    if (_unitNoController.text.length == 0) {
      setState(() {
        enableProceed = false;
        buttonText = "ENTER HOUSE / FLAT NO";
      });
    } else {
      setState(() {
        enableProceed = true;
        buttonText = "PLACE ORDER";
      });
    }
  }

  List<Map<String, int>> convertToMap() {
    List<Map<String, int>> suborderList = List();

    for (int i = 0; i < ConstantVariables.quantityList.length; i++) {
      if (ConstantVariables.quantityList[i] != 0) {
        Map<String, int> suborder = Map();
        suborder["item"] = ConstantVariables.productList[i].id;
        suborder["quantity"] = ConstantVariables.quantityList[i];
        suborderList.add(suborder);
      }
    }

    return suborderList;
  }

  Future<http.Response> createPost(PostOrder post) async {
    final response = await http.post(OrderStatic.keyOrderCreateURL,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: postOrderToJson(post));

    return response;
  }

  checkoutOrder() {
    PostOrder post = PostOrder(
      name: widget.name,
      mobile: widget.phone,
      email: widget.email,
      businessId: ConstantVariables.businessID,
      restaurant: widget.restaurant,
      preparationTime:
          _ptController.text.trim() != '' ? int.parse(_ptController.text) : 35,
      delivery: convertAddressToMap(),
      subOrderSet: suborderSet,
    );

    createPost(post).then((response) async {
      if (response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: "Order has been placed successfully!",
          fontSize: 13.0,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIos: 2,
        );
        Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
      } else if (response.statusCode == 400) {
        var json = JSON.jsonDecode(response.body);
        assert(json is Map);
        Fluttertoast.showToast(
          msg: json['detail'],
          fontSize: 13.0,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIos: 2,
        );
        await ConstantVariables.sentryClient.captureException(
          exception: Exception("Order Post Failure"),
          stackTrace: '[post: $post, response.body: ${response.body}, '
              'response.headers: ${response.headers}, response: $response]',
        );
      }
    }).catchError((error) async {
      await ConstantVariables.sentryClient.captureException(
        exception: Exception("Order Post Failure Error"),
        stackTrace: '[post: $post, error: ${error.toString()}]',
      );
    });
  }

  Map<String, dynamic> convertAddressToMap() {
    Map<String, dynamic> delivery = Map();
    delivery["location"] = _controller.text.trim();
    delivery["unit_no"] = _unitNoController.text.trim().toUpperCase();
    String addressLine = _landmarkController.text.trim();
    delivery["address_line_2"] = addressLine != ''
        ? '${addressLine[0].toUpperCase()}${addressLine.substring(1)}'
        : "";
    delivery["amount"] = widget.deliveryFee;
    delivery["latitude"] = ConstantVariables.userLatitude;
    delivery["longitude"] = ConstantVariables.userLongitude;

    return delivery;
  }
}
