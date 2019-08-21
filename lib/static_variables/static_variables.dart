import 'package:chakh_le_admin/entity/employee.dart';
import 'package:chakh_le_admin/entity/product.dart';
import 'package:chakh_le_admin/entity/restaurant.dart';
import 'package:sentry/sentry.dart';

class ConstantVariables {
  static int openRestaurantsCount;

  static int cartRestaurantId;

  static double userLatitude;
  static double userLongitude;

  static String userAddress;

  static bool hasLocationPermission;

  static int cartProductsCount;

  static Map<String, String> user = Map();
  static bool userLoggedIn = false;

  static String appName;
  static String packageName;
  static String version;
  static String buildNumber;

  static List<Employee> deliveryBoyList;
  static List<Restaurant> restaurantList;
  static List<String> deliveryBoyName;
  static int deliveryBoyCount;

  static List<Product> productList;
  static List<int> quantityList;

  static var connectionStatus;

  static List<dynamic> cuisines;
  static int businessID = 1;
  static int deliveryBoy;

  static Map<String, String> orderCode = {
    "New": "N",
    "Accepted": "Ac",
    "Preparing": "Pr",
    "On its way": "O",
    "Delivered": "D",
    "Cancelled": "C"
  };

  static List<String> order = [
    "New",
    "Accepted",
    "Preparing",
    "On its way",
    "Delivered",
    "Cancelled"
  ];

  static Map<String, String> codeOrder = {
    "N": "New",
    "Ac": "Accepted",
    "Pr": "Preparing",
    "O": "On its way",
    "D": "Delivered",
    "C": "Cancelled"
  };

  static SentryClient sentryClient;

  static var sentryDSN = "https://00ba7f023d974c3da7a4c13c594e6162:c4fe2855a00442779608078db6d617f0@sentry.io/1537721";
}
