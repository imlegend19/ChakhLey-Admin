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

  static List deliveryBoyList;
  static List restaurantList;
  static List<String> deliveryBoyName;
  static int deliveryBoyCount;

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
}
