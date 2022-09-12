import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';

class Product with ChangeNotifier {
  final _baseUrl = 'https://shopapp-ec7b4-default-rtdb.firebaseio.com/products';
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(String token) async {
    isFavorite = !isFavorite;
    notifyListeners();
    final response = await http.patch(
      Uri.parse('$_baseUrl/$id.json?auth=$token'),
      body: jsonEncode(
        {
          "isFavorite": isFavorite,
        },
      ),
    );
    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();
      throw HttpException(
        msg: 'Nao foi possível favoritar o produto',
        statusCode: response.statusCode,
      );
    }
  }
}
