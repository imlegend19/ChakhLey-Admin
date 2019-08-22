import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chakh_le_admin/entity/api_static.dart';
import 'package:chakh_le_admin/entity/order_post.dart';
import 'package:chakh_le_admin/entity/product.dart';
import 'package:chakh_le_admin/entity/restaurant.dart';
import 'package:chakh_le_admin/pages/checkout_page.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:chakh_le_admin/utils/color_loader.dart';
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
  double subTotal = 0;
  double tax = 0;
  double deliveryFee = 0;

  final TextEditingController _filter = TextEditingController();

  String _searchText = "";

  List<Product> _displayProducts = List();
  List<int> _displayQuantities = List();

  bool isLoading = false;
  bool _convertAppbar = false;

  Future<PostOrder> postOrder;
  List<Map<String, int>> suborderSet = List();

  @override
  void initState() {
    fetchProducts(SelectProductPage.restaurantID).then((val) {
      setState(() {
        ConstantVariables.productList = val.products;
        for (int i = 0; i < ConstantVariables.productList.length; i++) {
          _displayQuantities.add(0);
        }
        _displayProducts = ConstantVariables.productList;
        ConstantVariables.quantityList = _displayQuantities;
      });
    });

    fetchRestaurantData(SelectProductPage.restaurantID).then((val) {
      setState(() {
        restaurant = val.restaurants[0];
      });
    });

    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _displayProducts = ConstantVariables.productList;
          _displayQuantities = ConstantVariables.quantityList;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
          filterResults(_searchText);
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  filterResults(String query) {
    if (_displayProducts != null) {
      setState(() {
        _displayProducts = ConstantVariables.productList.where((val) {
          var name = val.name.toLowerCase();
          return name.contains(query);
        }).toList();

        List<int> tempQuantities = List();
        for (int i = 0; i < _displayProducts.length; i++) {
          tempQuantities.add(ConstantVariables.quantityList[
              ConstantVariables.productList.indexOf(_displayProducts[i])]);
        }

        _displayQuantities = tempQuantities;
      });
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Place Order ?"),
          content: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(text: 'Would you like to confirm your order?'),
                TextSpan(
                    text: ' Total Bill: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '${subTotal + tax}')
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: FlatButton(
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                FlatButton(
                  child: Text(
                    "Accept",
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CheckoutPage(
                              deliveryFee: deliveryFee,
                              total: subTotal + deliveryFee + tax,
                              name: widget.name,
                              email: widget.email,
                              phone: widget.phoneNumber,
                              restaurant: restaurant.id,
                            )));
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        cursorColor: Colors.white,
        highlightColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.redAccent,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: _convertAppbar
              ? TextField(
                  controller: _filter,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: 'Search...',
                    fillColor: Colors.white,
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hoverColor: Colors.white70,
                    focusColor: Colors.white70,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                )
              : Text('Select Products'),
          actions: <Widget>[
            //Adding the search widget in AppBar
            IconButton(
              tooltip: 'Search',
              icon: _convertAppbar
                  ? const Icon(Icons.close)
                  : const Icon(Icons.search),
              //Don't block the main thread
              onPressed: () {
                _convertAppbar
                    ? setState(() {
                        _convertAppbar = false;
                      })
                    : setState(() {
                        _searchText = "";
                        _filter.clear();
                        _convertAppbar = true;
                      });
              },
            ),
          ],
        ),
        floatingActionButton: Theme(
          data: Theme.of(context).copyWith(
            highlightColor: Colors.red.shade200,
          ),
          child: FloatingActionButton(
            onPressed: ConstantVariables.quantityList == null
                ? null
                : ConstantVariables.quantityList.reduce((a, b) => a + b) == 0
                    ? null
                    : () {
                        _showDialog();
                      },
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
            backgroundColor: ConstantVariables.quantityList == null
                ? Colors.red.shade200
                : ConstantVariables.quantityList.reduce((a, b) => a + b) == 0
                    ? Colors.red.shade200
                    : Colors.red,
            disabledElevation: 0,
            tooltip: "Post Order",
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: SingleChildScrollView(
                child: Column(
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
                    ConstantVariables.productList == null
                        ? Container()
                        : _generateSummary(),
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
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
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
                                    : restaurant.gst
                                        ? "Rs. ${subTotal * 0.05}"
                                        : "None",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  fontFamily: "Avenir",
                                  color: Colors.black54,
                                ),
                              ),
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
                                "Sub-Total",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0,
                                  fontFamily: "Avenir",
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                "Rs. $subTotal",
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
                                "Delivery Fee",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0,
                                  fontFamily: "Avenir",
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                "Rs. " + getDeliveryFee(subTotal).toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  fontFamily: "Avenir",
                                  color: Colors.black54,
                                ),
                              ),
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
                                  fontSize: 16.0,
                                  fontFamily: "Avenir",
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                "Rs. ${subTotal + tax + deliveryFee}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0,
                                  fontFamily: "Avenir",
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            ConstantVariables.productList == null
                ? Expanded(
                    child: Container(
                      width: double.infinity,
                      child: ColorLoader(),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: _buildProducts(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<http.Response> createPost(PostOrder post) async {
    final response = await http.post(TransactionStatic.transactionCreateURL,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: postOrderToJson(post));

    return response;
  }

  void _add(int displayIndex) {
    ConstantVariables.quantityList[displayIndex] += 1;
  }

  void _subtract(int displayIndex) {
    ConstantVariables.quantityList[displayIndex] -= 1;
  }

  Widget _generateSummary() {
    List<Widget> prods = List();
    double xTotal = 0;

    for (int i = 0; i < ConstantVariables.productList.length; i++) {
      if (ConstantVariables.quantityList[i] > 0) {
        xTotal += ConstantVariables.productList[i].displayPrice *
            ConstantVariables.quantityList[i];
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
                    ConstantVariables.productList[i].name,
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
                  " x " + ConstantVariables.quantityList[i].toString(),
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

    subTotal = xTotal;
    if (restaurant != null) {
      if (restaurant.gst) {
        tax = xTotal * 0.05;
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: prods,
    );
  }

  double getDeliveryFee(double subTotal) {
    if (subTotal == 0) {
      deliveryFee = 0;
      return 0;
    } else if (subTotal <= 200) {
      deliveryFee = 30;
      return 30;
    } else if (subTotal > 200 && subTotal <= 1000) {
      deliveryFee = 25;
      return 25;
    } else {
      deliveryFee = 15;
      return 15;
    }
  }

  Widget _buildProducts() {
    return ListView.builder(
        itemCount: _displayProducts.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == _displayProducts.length) {
            return SizedBox(
              height: 100,
            );
          } else {
            AssetImage image;
            if (ConstantVariables
                .productList[ConstantVariables.productList
                    .indexOf(_displayProducts[index])]
                .isVeg) {
              image = AssetImage('assets/veg.png');
            } else {
              image = AssetImage('assets/non_veg.png');
            }
            return Container(
              color: Colors.grey[200],
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
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
                              ConstantVariables.quantityList[ConstantVariables
                                          .productList
                                          .indexOf(_displayProducts[index])] !=
                                      0
                                  ? IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () => setState(
                                        () => _subtract(ConstantVariables
                                            .productList
                                            .indexOf(_displayProducts[index])),
                                      ),
                                    )
                                  : Container(),
                              Text(ConstantVariables.quantityList[
                                      ConstantVariables.productList
                                          .indexOf(_displayProducts[index])]
                                  .toString()),
                              ConstantVariables.quantityList[ConstantVariables
                                          .productList
                                          .indexOf(_displayProducts[index])] !=
                                      50
                                  ? IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () => setState(
                                        () => _add(ConstantVariables.productList
                                            .indexOf(_displayProducts[index])),
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
        });
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
//
//  checkoutOrder() {
//    PostOrder post = PostOrder(
//        name: widget.name,
//        mobile: widget.phoneNumber,
//        email: widget.email != null ? widget.email : "",
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
