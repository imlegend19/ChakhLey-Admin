import 'dart:convert';

import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'api_static.dart';

class Restaurant {
  final int id;
  final String name;
  final int businessId;
  final int deliveryTime;
  final String fullAddress;
  final bool openStatus;
  final String costForTwo;
  final int categoryCount;
  final int commission;
  final bool isVeg;
  final bool isActive;
  final bool gst;

  Restaurant({
    this.id,
    this.name,
    this.businessId,
    this.deliveryTime,
    this.fullAddress,
    this.openStatus,
    this.costForTwo,
    this.categoryCount,
    this.commission,
    this.isVeg,
    this.isActive,
    this.gst,
  });
}

class GetRestaurant {
  List<Restaurant> restaurants;
  int count;
  int openRestaurantsCount;

  GetRestaurant({this.restaurants, this.count, this.openRestaurantsCount});

  factory GetRestaurant.fromJson(Map<String, dynamic> response) {
    List<Restaurant> restaurants = [];
    int count = response[APIStatic.keyCount];

    List<dynamic> results = response[APIStatic.keyResult];

    for (int i = 0; i < results.length; i++) {
      Map<String, dynamic> jsonRestaurant = results[i];
      restaurants.add(
        Restaurant(
          id: jsonRestaurant[APIStatic.keyID],
          name: jsonRestaurant[APIStatic.keyName],
          businessId: jsonRestaurant[RestaurantStatic.keyBusinessId],
          deliveryTime: jsonRestaurant[RestaurantStatic.keyDeliveryTime],
          fullAddress: jsonRestaurant[RestaurantStatic.keyFullAddress],
          openStatus: jsonRestaurant[RestaurantStatic.keyOpen],
          costForTwo: jsonRestaurant[RestaurantStatic.keyCostForTwo],
          categoryCount: jsonRestaurant[RestaurantStatic.keyCategoryCount],
          commission: jsonRestaurant[RestaurantStatic.keyCommission],
          isVeg: jsonRestaurant[RestaurantStatic.keyIsVeg],
          isActive: jsonRestaurant[RestaurantStatic.keyIsActive],
          gst: jsonRestaurant[RestaurantStatic.keyGST],
        ),
      );
    }

    count = restaurants.length;
    ConstantVariables.cuisines = response[RestaurantStatic.keyCuisines];

    return GetRestaurant(
        restaurants: restaurants,
        count: count,
        openRestaurantsCount:
            response[RestaurantStatic.keyOpenRestaurantsCount]);
  }
}

Future<GetRestaurant> fetchRestaurant(int businessID) async {
  final response =
      await http.get(RestaurantStatic.keyRestaurantURL + '?business=$businessID');

  if (response.statusCode == 200) {
    int count = jsonDecode(response.body)[APIStatic.keyCount];
    int execute = count ~/ 10 + 1;

    GetRestaurant restaurant =
        GetRestaurant.fromJson(jsonDecode(response.body));
    execute--;

    while (execute != 0) {
      GetRestaurant tempRestaurant = GetRestaurant.fromJson(jsonDecode(
          (await http.get(jsonDecode(response.body)[APIStatic.keyNext])).body));
      restaurant.restaurants += tempRestaurant.restaurants;
      restaurant.count += tempRestaurant.count;

      execute--;
    }

    return restaurant;
  } else {
    await ConstantVariables.sentryClient.captureException(
      exception: Exception("Restaurant Get Failure"),
      stackTrace: '[response.body: ${response.body}, '
          'response.headers: ${response.headers}, response: $response,'
          'status code: ${response.statusCode}]',
    );

    return null;
  }
}

Future<GetRestaurant> fetchRestaurantData(int id) async {
  final response =
      await http.get(RestaurantStatic.keyRestaurantDetailURL + id.toString());

  if (response.statusCode == 200) {
    GetRestaurant restaurant =
        GetRestaurant.fromJson(jsonDecode(response.body));

    return restaurant;
  } else {
    Fluttertoast.showToast(
      msg: "Some error occurred!",
      fontSize: 13.0,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 1,
    );

    await ConstantVariables.sentryClient.captureException(
      exception: Exception("Restaurant Retrieve Failure"),
      stackTrace: '[id: $id, response.body: ${response.body}, '
          'response.headers: ${response.headers}, response: $response,'
          'status code: ${response.statusCode}]',
    );

    return null;
  }
}

patchRestaurantOpen(bool isActive, int id) async {
  var json = {"is_active": isActive};

  http.Response response = await http.patch(
    RestaurantStatic.keyRestaurantURL + id.toString() + '/',
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(json),
  );

  if (response.statusCode == 200) {
    Fluttertoast.showToast(
      msg: "Restaurant ${isActive ? "Open" : "Closed"}",
      fontSize: 13.0,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 2,
    );
  } else if (response.statusCode == 503) {
    Fluttertoast.showToast(
      msg: "Please check your internet!",
      fontSize: 13.0,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 2,
    );

    await ConstantVariables.sentryClient.captureException(
      exception: Exception("Restaurant Patch Failure"),
      stackTrace:
          '[id: $id, active: $isActive, response.body: ${response.body}, '
          'response.headers: ${response.headers}, response: $response,'
          'status code: ${response.statusCode}]',
    );

    return null;
  } else {
    Fluttertoast.showToast(
      msg: 'Error!!',
      fontSize: 13.0,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 2,
    );

    await ConstantVariables.sentryClient.captureException(
      exception: Exception("Restaurant Patch Failure"),
      stackTrace:
          '[id: $id, active: $isActive, response.body: ${response.body}, '
          'response.headers: ${response.headers}, response: $response,'
          'status code: ${response.statusCode}]',
    );

    return null;
  }
}
