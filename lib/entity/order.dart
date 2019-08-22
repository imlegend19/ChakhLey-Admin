import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'api_static.dart';

class Order {
  final int id;
  final String name;
  final String mobile;
  final String email;
  final Map<String, dynamic> restaurant;
  final String preparationTime;
  final String status;
  final String orderDate;
  final double total;
  final bool paymentDone;
  final List<dynamic> suborderSet;
  final Map<String, dynamic> delivery;
  final Map<String, dynamic> deliveryBoy;
  final bool hasDeliveryBoy;

  Order({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.restaurant,
    this.preparationTime,
    this.status,
    this.orderDate,
    this.total,
    this.paymentDone,
    this.suborderSet,
    this.delivery,
    this.deliveryBoy,
    this.hasDeliveryBoy,
  });
}

class GetOrders {
  List<Order> orders;
  int count;

  GetOrders({this.orders, this.count});

  factory GetOrders.fromJson(Map<String, dynamic> response) {
    List<Order> orders = [];
    int count = response[APIStatic.keyCount];

    List<dynamic> results = response[APIStatic.keyResult];

    for (int i = 0; i < results.length; i++) {
      Map<String, dynamic> jsonOrder = results[i];
      orders.add(
        Order(
          id: jsonOrder[APIStatic.keyID],
          name: jsonOrder[APIStatic.keyName],
          mobile: jsonOrder[RestaurantStatic.keyMobile],
          email: jsonOrder[RestaurantStatic.keyEmail],
          restaurant: jsonOrder[RestaurantStatic.keyRestaurant],
          preparationTime: jsonOrder[OrderStatic.keyPreparationTime],
          status: jsonOrder[OrderStatic.keyStatus],
          orderDate: jsonOrder[OrderStatic.keyOrderDate],
          total: jsonOrder[OrderStatic.keyTotal],
          paymentDone: jsonOrder[OrderStatic.keyPaymentDone],
          suborderSet: jsonOrder[OrderStatic.keySuborderSet],
          delivery: jsonOrder[OrderStatic.keyDelivery],
          deliveryBoy: jsonOrder[OrderStatic.keyDeliveryBoy],
          hasDeliveryBoy: jsonOrder[OrderStatic.keyHasDeliveryBoy],
        ),
      );
    }

    count = orders.length;

    return GetOrders(orders: orders, count: count);
  }
}

Future<GetOrders> fetchOrder(String status) async {
  final response = await http
      .get(OrderStatic.keyOrderListURL + status)
      .catchError((error) {});

  if (response.statusCode == 200) {
    int count = jsonDecode(response.body)[APIStatic.keyCount];
    int execute = count != 0 ? count ~/ 10 + 1 : 0;

    GetOrders order = GetOrders.fromJson(jsonDecode(response.body));
    execute == 0 ? execute = 0 : execute--;

    while (execute != 0) {
      GetOrders tempOrder = GetOrders.fromJson(jsonDecode(
          (await http.get(jsonDecode(response.body)[APIStatic.keyNext])).body));
      order.orders += tempOrder.orders;
      order.count += tempOrder.count;
      execute--;
    }

    return order;
  } else {
    throw Exception('Failed to load get');
  }
}

Future<GetOrders> fetchOrderDeliveryBoy(String status, int deliveryBoy) async {
  final response = await http.get(OrderStatic.keyOrderListURL +
      status +
      OrderStatic.keyDeliveryBoyAddUrL +
      '$deliveryBoy');

  if (response.statusCode == 200) {
    int count = jsonDecode(response.body)[APIStatic.keyCount];
    int execute = count ~/ 10 + 1;

    GetOrders order = GetOrders.fromJson(jsonDecode(response.body));
    execute--;

    while (execute != 0) {
      GetOrders tempOrder = GetOrders.fromJson(jsonDecode(
          (await http.get(jsonDecode(response.body)[APIStatic.keyNext])).body));
      order.orders += tempOrder.orders;
      order.count += tempOrder.count;
      execute--;
    }

    return order;
  } else {
    print(response.body);
    throw Exception('Failed to load get');
  }
}

patchOrder(int id, String status) async {
  var json = {"status": "$status"};

  http.Response response = await http.patch(
    OrderStatic.keyOrderDetailURL + id.toString() + '/',
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(json),
  );

  if (response.statusCode == 200) {
    Fluttertoast.showToast(
      msg: "Status Updated",
      fontSize: 13.0,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIos: 2,
    );
  } else if (response.statusCode == 503) {
    Fluttertoast.showToast(
      msg: "Please check your internet!",
      fontSize: 13.0,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIos: 2,
    );
  } else {
    Fluttertoast.showToast(
      msg: 'Error!!',
      fontSize: 13.0,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIos: 2,
    );
  }
}

patchOrderDeliveryBoy(int id, String status, int deliveryBoy) async {
  var json = {"status": "$status", "delivery_boy": deliveryBoy};

  http.Response response = await http.patch(
    OrderStatic.keyOrderDetailURL + id.toString() + '/',
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(json),
  );

  if (response.statusCode == 200) {
    Fluttertoast.showToast(
      msg: "Status Updated",
      fontSize: 13.0,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIos: 2,
    );
  } else if (response.statusCode == 503) {
    Fluttertoast.showToast(
      msg: "Please check your internet!",
      fontSize: 13.0,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIos: 2,
    );
  } else {
    Fluttertoast.showToast(
      msg: '${response.statusCode}',
      fontSize: 13.0,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIos: 2,
    );
  }
}
