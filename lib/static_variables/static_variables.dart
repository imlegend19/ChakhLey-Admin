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

  static var deliveryBoyList;
  static int deliveryBoyCount;

  static Map<String, String> orderCode = {
    "Pending": "Pe",
    "Accepted": "Ac",
    "Preparing": "Pr",
    "Ready": "R",
    "Dispatched": "Di",
    "Delivered": "D",
    "Cancelled": "C"
  };

  static List<String> order = [
    "Pending",
    "Accepted",
    "Preparing",
    "Ready",
    "Dispatched",
    "Delivered",
    "Cancelled"
  ];

  static Map<String, String> codeOrder = {
    "Pe": "Pending",
    "Ac": "Accepted",
    "Pr": "Preparing",
    "R": "Ready",
    "Di": "Dispatched",
    "D": "Delivered",
    "C": "Cancelled"
  };
}
