import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chakh_le_admin/entity/api_static.dart';
import 'package:chakh_le_admin/entity/order_post.dart';
import 'package:chakh_le_admin/entity/product.dart';
import 'package:chakh_le_admin/entity/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectProductPage extends StatefulWidget {
  static int restaurantID;
  final String name;
  final String email;
  final String phoneNumber;

  SelectProductPage({
    this.name,
    this.email,
    this.phoneNumber,
  });

  @override
  _SelectProductPageState createState() => _SelectProductPageState();
}

class _SelectProductPageState extends State<SelectProductPage> {
  List<bool> productsVal = [];
  bool disableApply = true;
  Restaurant restaurant;
  double total = 0;
  double tax = 0;

  List<Product> _displayProducts = List();
  List<int> _quantities = List();

  bool isLoading = false;

  Future<PostOrder> postOrder;
  List<Map<String, int>> suborderSet = List();

  @override
  void initState() {
    fetchProducts(SelectProductPage.restaurantID).then((val) {
      setState(() {
        _displayProducts = val.products;
        for (int i = 0; i < _displayProducts.length; i++) {
          _quantities.add(0);
        }
      });
    });

    fetchRestaurantData(SelectProductPage.restaurantID).then((val) {
      setState(() {
        restaurant = val.restaurants[0];
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Products'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Order Summary",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "AvenirBold",
                      color: Colors.black,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 14.0, left: 8.0, right: 8.0),
                child: SizedBox(
                  height: 3.0,
                  child: Container(
                    color: Colors.black54,
                  ),
                ),
              ),
              _generateSummary(),
              Padding(
                padding: const EdgeInsets.only(
                    top: 14.0, bottom: 14.0, left: 8.0, right: 8.0),
                child: SizedBox(
                  height: 3.0,
                  child: Container(
                    color: Colors.black54,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Taxes",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0,
                            fontFamily: "Avenir",
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          restaurant == null
                              ? "Rs. --"
                              : restaurant.gst ? "Rs. ${total * 0.05}" : "None",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 13.0,
                            fontFamily: "Avenir",
                            color: Colors.black54,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Total",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15.0,
                            fontFamily: "Avenir",
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          "Rs. $total",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            fontFamily: "Avenir",
                            color: Colors.black54,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                itemCount: _displayProducts.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  AssetImage image;
                  if (index == _displayProducts.length) {
                    return _buildProgressIndicator();
                  } else {
                    if (_displayProducts[index].isVeg) {
                      image = AssetImage('assets/veg.png');
                    } else {
                      image = AssetImage('assets/non_veg.png');
                    }
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, bottom: 5.0, right: 8.0),
                              child: Image(
                                image: image,
                                fit: BoxFit.contain,
                                height: 23.0,
                                width: 23.0,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: AutoSizeText(
                                          _displayProducts[index].name,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'Avenir-Bold',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                          ),
                                          maxLines: 3,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        "₹ " +
                                            '${_displayProducts[index].displayPrice}',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: 'Avenir-Black',
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      _quantities[index] != 0
                                          ? IconButton(
                                              icon: Icon(Icons.remove),
                                              onPressed: () => setState(
                                                () => _subtract(index),
                                              ),
                                            )
                                          : Container(),
                                      Text(_quantities[index].toString()),
                                      _quantities[index] != 50
                                          ? IconButton(
                                              icon: Icon(Icons.add),
                                              onPressed: () => setState(
                                                () => _add(index),
                                              ),
                                            )
                                          : IconButton(
                                              icon: Icon(
                                                Icons.add,
                                                color: Colors.transparent,
                                              ),
                                              onPressed: null,
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<http.Response> createPost(PostOrder post) async {
    final response = await http.post(TransactionStatic.transactionCreateURL,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: postOrderToJson(post));

    return response;
  }

  void _add(int index) {
    _quantities[index] += 1;
  }

  void _subtract(int index) {
    _quantities[index] -= 1;
  }

  Widget _generateSummary() {
    List<Widget> prods = List();
    double xtotal = 0;
    double xtax = 0;

    for (int i = 0; i < _displayProducts.length; i++) {
      if (_quantities[i] > 0) {
        xtotal += _displayProducts[i].displayPrice * _quantities[i];
        prods.add(Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text(
                    _displayProducts[i].name,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Avenir",
                      color: Colors.black87,
                    ),
                    maxLines: 3,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  " x " + _quantities[i].toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Avenir",
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ));
      }
    }

    total = xtotal;
    if (restaurant != null) {
      if (restaurant.gst) {
        tax = xtotal * 0.05;
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: prods,
    );
  }

//  List<Map<String, int>> convertToMap(List<Product> product) {
//    List<Map<String, int>> suborderList = List();
//
//    for(final i in products){
//      Map<String, int> suborder = Map();
//      suborder["item"] = i.id;
//      suborder["quantity"] = i.quantity;
//      suborderList.add(suborder);
//    }
//
//    return suborderList;
//  }

//  checkoutOrder() {
//    PostOrder post = PostOrder(
//        name: widget.name,
//        mobile: widget.phoneNumber,
//        email: widget.email,
//        restaurant: SelectProductPage.restaurantID,
//        business: 1,
//        preparationTime: ,
//        delivery: ,
//        subOrderSet: suborderSet);
//
//    createPost(post).then((response) {
//      if (response.statusCode == 201) {
//
//        Fluttertoast.showToast(
//          msg: "Order Placed Sucessfully",
//          fontSize: 13.0,
//          toastLength: Toast.LENGTH_LONG,
//          timeInSecForIos: 2,
//        );
//      } else if (response.statusCode == 400) {
//        // print(response.body);
//      }
//    }).catchError((Object error) {
//      Fluttertoast.showToast(
//        msg: "Please check your internet!",
//        fontSize: 13.0,
//        toastLength: Toast.LENGTH_LONG,
//        timeInSecForIos: 2,
//      );
//    }).catchError((error) {
//      Fluttertoast.showToast(
//        msg: error.toString(),
//        fontSize: 13.0,
//        toastLength: Toast.LENGTH_LONG,
//        timeInSecForIos: 2,
//      );
//    });
//  }

}
