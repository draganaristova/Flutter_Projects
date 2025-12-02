import '../models/recipe.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<Recipe> _cartItems = [];

  List<Recipe> get cartItems => _cartItems;

  void addRecipe(Recipe recipe) {
    if (!_cartItems.contains(recipe)) {
      _cartItems.add(recipe);
    }
  }

  void removeRecipe(Recipe recipe) {
    _cartItems.remove(recipe);
  }

  void clear() {
    _cartItems.clear();
  }
}
