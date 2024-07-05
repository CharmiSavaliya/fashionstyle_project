import 'package:flutter/foundation.dart';
import 'package:fashion_project/model/cardview_model.dart';

class FavoriteModel with ChangeNotifier {
  final List<ProductModel> _favorites = [];

  List<ProductModel> get favorites => _favorites;

  void addFavorite(ProductModel product) {
    if (!_favorites.contains(product)) {
      _favorites.add(product);
      notifyListeners();
    }
  }

  void removeFavorite(ProductModel product) {
    if (_favorites.contains(product)) {
      _favorites.remove(product);
      notifyListeners();
    }
  }

  bool isFavorite(ProductModel product) {
    return _favorites.contains(product);
  }
}
