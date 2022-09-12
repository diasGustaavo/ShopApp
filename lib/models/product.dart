import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';

class Product with ChangeNotifier {
  final _baseUrl = 'https://shopapp-ec7b4-default-rtdb.firebaseio.com/products';
  final _favoriteUrl =
      'https://shopapp-ec7b4-default-rtdb.firebaseio.com/userFavorites';
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

  Future<void> toggleFavorite(String token, String userId) async {
    isFavorite = !isFavorite;
    notifyListeners();
    final response = await http.put(
      Uri.parse('$_favoriteUrl/$userId/$id.json?auth=$token'),
      body: jsonEncode(isFavorite),
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
