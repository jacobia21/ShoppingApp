import 'dart:convert';

import 'package:ShoppingApp/models/http_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  ProductProvider({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String authToken) async {
    final url = 'https://shopping-app-jacobia.firebaseio.com/products/$id.json?auth=$authToken';
    var originalFavoriteStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final response = await http.patch(
      url,
      body: json.encode({
        'isFavorite': isFavorite,
      }),
    );
    if (response.statusCode >= 400) {
      isFavorite = originalFavoriteStatus;
      notifyListeners();
      throw HttpException('Could not update Favorite status');
    }
  }
}
