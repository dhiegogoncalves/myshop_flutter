import 'package:flutter/foundation.dart';
import 'package:myshop_flutter/data/dummy_data.dart';
import 'package:myshop_flutter/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
