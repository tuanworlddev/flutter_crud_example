import 'dart:io';

import 'package:crud_example/models/product.dart';
import 'package:crud_example/services/product_service.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> _products = [];

  List<Product> get products => _products;

  ProductProvider() {
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    _productService.products().listen((products) {
      _products = products;
      notifyListeners();
    });
  }

  Future<void> addProduct(Product product, File? imageFile) async {
    await _productService.addProduct(product, imageFile);
    notifyListeners();
  }

  Future<void> updateProduct(Product product, File? imageFile) async {
    await _productService.updateProduct(product, imageFile);
    notifyListeners();
  }

  Future<void> deleteProduct(String productId) async {
    await _productService.deleteProduct(productId);
    notifyListeners();
  }

}