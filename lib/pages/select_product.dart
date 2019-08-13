import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chakh_le_admin/entity/api_static.dart';
import 'package:chakh_le_admin/entity/order_post.dart';
import 'package:chakh_le_admin/entity/product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SelectProductPage extends StatefulWidget {
  static int restaurantID;
  String name;
  String email;
  String phoneNumber;

  SelectProductPage(name, email, phoneNumber);
  @override
  _SelectProductPageState createState() => _SelectProductPageState();
}

class _SelectProductPageState extends State<SelectProductPage> {
  List<bool> productsVal = [];
  bool disableApply = true;

  List<Product> products = List();

  String nextPage = ProductStatic.keyProductURL +
      "?category__restaurant__id=" +
      '${SelectProductPage.restaurantID}';
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  Future<PostOrder> postOrder;
  List<Map<String, int>> suborderSet = List();

  @override
  void initState() {
    this._getMoreData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(nextPage);
      List<Product> tempList = List();
      List<bool> tempVal = List();

      if (response.statusCode == 200) {
        GetProducts product = GetProducts.fromJson(jsonDecode(response.body));
        nextPage = product.next;
        tempList = product.products;
        tempVal = List<bool>.generate(tempList.length, (i) => false);
      } else {
        print(response.body);
        throw Exception('Failed to load get');
      }

      setState(() {
        isLoading = false;
        products.addAll(tempList);
        productsVal.addAll(tempVal);
      });
    }
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
          title: Text('Select Product'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              color: Colors.blueAccent,
              height: 60.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    AssetImage image;
                    if (index == products.length) {
                      return _buildProgressIndicator();
                    } else {
                      if (products[index].isVeg) {
                        image = AssetImage('assets/veg.png');
                      } else {
                        image = AssetImage('assets/non_veg.png');
                      }
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3.0, bottom: 3.0, left: 5.0, right: 5.0),
                          child: ListTile(
                            title: Row(
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          AutoSizeText(
                                            products[index].name,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'Avenir-Bold',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                            ),
                                            maxLines: 2,
                                          ),
                                          SizedBox(
                                            height: 2.0,
                                          ),
                                          Text(
                                            "₹ " +
                                                '${products[index].displayPrice}',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontFamily: 'Avenir-Black',
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            Center(
              child: RaisedButton(
                color: Colors.redAccent,
                disabledColor: Colors.red.shade200,
                onPressed: () {},
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ],
        ));
  }

  Future<http.Response> createPost(PostOrder post) async {
    final response = await http.post(TransactionStatic.transactionCreateURL,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: postOrderToJson(post));

    return response;
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
