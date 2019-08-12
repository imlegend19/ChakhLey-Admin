import 'dart:convert';

import 'package:http/http.dart' as http;
import 'api_static.dart';

class Product {
  final int id;
  final String name;
  final bool isVeg;
  final bool active;
  final double displayPrice;

  Product({
    this.id,
    this.name,
    this.isVeg,
    this.active,
    this.displayPrice,
  });
}

class GetProducts {
  List<Product> products;
  int count;
  String next;

  GetProducts({this.products, this.count, this.next});

  factory GetProducts.fromJson(Map<String, dynamic> response) {
    List<Product> products = [];
    int count = response[APIStatic.keyCount];
    String next = response[APIStatic.keyNext];

    List<dynamic> results = response[APIStatic.keyResult];

    for (int i = 0; i < results.length; i++) {
      Map<String, dynamic> jsonOrder = results[i];
      products.add(
        Product(
          id: jsonOrder[APIStatic.keyID],
          name: jsonOrder[APIStatic.keyName],
          isVeg: jsonOrder[ProductStatic.keyIsVeg],
          active: jsonOrder[ProductStatic.keyActive],
          displayPrice: jsonOrder[ProductStatic.keyDisplayPrice],
        ),
      );
    }

    count = products.length;

    return GetProducts(products: products, count: count, next: next);
  }
}

Future<GetProducts> fetchProducts(int restaurantId) async {
  final response = await http.get(ProductStatic.keyProductURL +
      "?category__restaurant__id=" +
      '$restaurantId');

  if (response.statusCode == 200) {
    int count = jsonDecode(response.body)[APIStatic.keyCount];
    int execute = count ~/ 10 + 1;

    GetProducts product = GetProducts.fromJson(jsonDecode(response.body));
    execute--;

    while (execute != 0) {
      GetProducts tempProduct = GetProducts.fromJson(jsonDecode(
          (await http.get(jsonDecode(response.body)[APIStatic.keyNext])).body));
      product.products += tempProduct.products;
      product.count += tempProduct.count;
      execute--;
    }

    return product;
  } else {
    print(response.body);
    throw Exception('Failed to load get');
  }
}
