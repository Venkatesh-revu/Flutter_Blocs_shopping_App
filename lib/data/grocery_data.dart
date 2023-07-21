import 'dart:convert';

import 'package:http/http.dart';

import '../product_model.dart';

class GroceryData {
  String productsUrl = 'https://fakestoreapi.com/products';

  Future<List<ProductModel>> getProducts() async {
    Response response = await get(Uri.parse(productsUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
