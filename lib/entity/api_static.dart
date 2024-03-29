abstract class APIStatic {
  static const baseURL = "http://adminbeta.chakhley.co.in/api/";

  static const keyID = "id";
  static const keyName = "name";
  static const keyCount = "count";
  static const keyNext = "next";
  static const keyResult = "results";
  static const keyPrevious = "previous";
  static const keyPage = "page";
  static const keyLast = "last";
  static const keySuccess = "success";
  static const keyMessage = "message";
  static const keyDetail = "detail";

  static const keyMobile = "mobile";
  static const keyEmail = "email";

  static const keyBusiness = "business";

  static const dateTimeFormat = "yyyy-MM-dd'T'HH:mm:ss";
  static const onlyDateFormat = "yyyyMMdd";
}

abstract class BusinessStatic {
  static const businessURL = APIStatic.baseURL + "business/";

  static const keyType = "type";
  static const keyCity = "city";
}

abstract class LocationStatic {
  static const keyCityURL = APIStatic.baseURL + "location/city/";
  static const keyAreaURL = APIStatic.baseURL + "location/area/";
  static const keyStateURL = APIStatic.baseURL + "location/state/";
  static const keyCountryURL = APIStatic.baseURL + "location/country/";
  static const keyComplexURL = APIStatic.baseURL + "location/complex/";

  static const keyCity = "city";
  static const keyState = "state";
  static const keyCountry = "country";
  static const keyBuildingName = "building_name";
  static const keyArea = "area";
  static const keyFlatNumber = "flat_number";
  static const keyPinCode = "pincode";
}

abstract class EmployeeStatic {
  static const keyEmployeeURL = APIStatic.baseURL + "employee/";

  static const keyIsActive = "is_active";
  static const keyUserID = "user_id";
  static const keyUserName = "user_name";
  static const keyUserMobile = "user_mobile";
  static const keyBusinessId = "business_id";
}

abstract class ProductStatic {
  static const keyProductURL = APIStatic.baseURL + "product/product/";
  static const keyCategoryURL = APIStatic.baseURL + "product/category/";

  static const keyCategory = "category";
  static const keyIsVeg = "is_veg";
  static const keyPrice = "price";
  static const keyProductCount = "product_count";
  static const keyRestaurant = "restaurant";
  static const keyDisplayPrice = "display_price";
  static const keyRecommendedProduct = "recommended_product";
  static const keyActive = "active";
  static const keyDiscount = "discount";
  static const keyInflation = "inflation";
}

abstract class RestaurantStatic {
  static const restaurant_suffix = "restaurant/";
  static const keyRestaurantURL = APIStatic.baseURL + restaurant_suffix;
  static const keyRestaurantImageURL =
      APIStatic.baseURL + restaurant_suffix + "image/";
  static const keyRestaurantDetailURL =
      APIStatic.baseURL + restaurant_suffix + "?id=";

  static const keyBusinessId = "business_id";
  static const keyUnit = "unit";
  static const keyPhone = "phone";
  static const keyMobile = "mobile";
  static const keyEmail = "email";
  static const keyWebsite = "website";
  static const keyIsActive = "is_active";
  static const keyCostForTwo = "cost_for_two";
  static const keyCuisine = "cuisine";
  static const keyEstablishment = "establishment";
  static const keyDeliveryTime = "delivery_time";
  static const keyIsVeg = "is_veg";
  static const keyFullAddress = "full_address";
  static const keyOpenRestaurantsCount = "open_restaurants";
  static const keyOpen = "open";
  static const keyCategoryCount = "category_count";
  static const keyTotal = "total";
  static const keyPreparationTime = "preparation_time";

  static const keyDelivery = "delivery";
  static const keySubOrderSet = "suborder_set";

  static const keyItem = "item";
  static const keyQuantity = "quantity";
  static const keyRestaurant = "restaurant";

  static const keyLatitude = "latitude";
  static const keyLongitude = "longitude";
  static const keyImages = "images";
  static const keyCuisines = "cuisines";
  static const keyCommission = "commission";
  static const keyGST = "gst";
}

abstract class UserStatic {
  static const keyRegisterURL = APIStatic.baseURL + "user/register/";
  static const keyOTPRegURL = APIStatic.baseURL + "user/otpreglogin/";
  static const keyOtpURL = APIStatic.baseURL + "user/otp/";
  static const keyLoginURL = APIStatic.baseURL + "user/login/";
  static const keyGetUsersURL = APIStatic.baseURL + "user/account";
}

abstract class DeliveryStatic {
  static const keyAmount = "amount";
  static const keyLocation = "location";
  static const keyUnitNo = "unit_no";
  static const keyAddressLine = "address_line_2";
  static const keyFullAddress = "full_address";
}

abstract class SuborderSetStatic {
  static const keyProduct = "product";
  static const keyCategory = "category";
  static const keyIsVeg = "is_veg";
  static const keyPrice = "price";
  static const keyRestaurant = "restaurant";
  static const keyQuantity = "quantity";
  static const keySubTotal = "sub_total";
}

abstract class OrderStatic {
  ///
  /// {
  ///      "id": 2,
  ///      "name": "John Doe",
  ///      "mobile": "9245671324",
  ///      "email": "john.doe@gmail.com",
  ///      "business": 1,
  ///      "restaurant_id": 1,
  ///      "restaurant_name": "Hot Oven Delivery (HOD)",
  ///      "preparation_time": "00:00:40",
  ///      "status": "Delivered",
  ///      "order_date": "2019-08-21T00:51:51.411893+05:30",
  ///      "total": 250,
  ///      "packaging_charge": 0,
  ///      "payment_done": true,
  ///      "delivery": <DeliveryObject>,
  ///      "suborder_set": [<SubOrderSetObject>],
  ///      "delivery_boy": <EmployeeObject>,
  ///      "has_delivery_boy": true
  ///    }
  ///

  static const keyOrderCreateURL = APIStatic.baseURL + "order/create/";
  static const keyOrderListURL = APIStatic.baseURL + "order/list/?status=";
  static const keyDeliveryBoyUserAddUrL = "&delivery_boy__user__id=";
  static const keyOrderDetailURL = APIStatic.baseURL + "order/";

  static const keyBusinessId = "business";
  static const keyMobile = "mobile";
  static const keyEmail = "email";
  static const keyPreparationTime = "preparation_time";
  static const keyRestaurantId = "restaurant";
  static const keyRestaurantName = "restaurant_name";
  static const keyPackagingCharge = "packaging_charge";
  static const keySubOrderSet = "suborder_set";
  static const keyDelivery = "delivery";
  static const keyPaymentDone = "payment_done";
  static const keyTotal = "total";
  static const keyOrderDate = "order_date";
  static const keyStatus = "status";
  static const keyHasDeliveryBoy = "has_delivery_boy";
  static const keyDeliveryBoy = "delivery_boy";
}

abstract class TransactionStatic {
  static const transactionURL = APIStatic.baseURL + "transactions/list/?order=";
  static const transactionCreateURL =
      APIStatic.baseURL + "transactions/create/";

  static const keyOrder = "order";
  static const keyAmount = "amount";
  static const keyIsCredit = "is_credit";
  static const keyPaymentType = "payment_type";
  static const keyPaymentMode = "payment_mode";
  static const keyAcceptedBy = "accepted_by";
}
