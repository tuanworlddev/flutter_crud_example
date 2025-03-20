import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_example/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductService {
  final CollectionReference _productCollection = FirebaseFirestore.instance
      .collection('products');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Stream<List<Product>> products() {
    return _productCollection.snapshots().map(
      (snapshot) =>
          snapshot.docs
              .map(
                (doc) =>
                    Product.fromMap(doc.data() as Map<String, dynamic>, doc.id),
              )
              .toList(),
    );
  }

  Future<void> addProduct(Product product, File? imageFile) async {
    if (imageFile != null) {
      final imageUrl = await _uploadImage(imageFile);
      if (imageUrl != null) {
        product.imageUrl = imageUrl;
      }
    }
    await _productCollection.add(product.toMap());
  }

  Future<void> updateProduct(Product product, File? imageFile) async {
    if (imageFile != null) {
      final imageUrl = await _uploadImage(imageFile);
      if (imageUrl != null) {
        product.imageUrl = imageUrl;
      }
    }
    await _productCollection.doc(product.id).update(product.toMap());
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _productCollection.doc(productId).delete();
    } catch (e) {
      print('Error delete product: $e');
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    try {
      final ref = _storage.ref().child('images/${DateTime.now()}');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error upload file: $e');
      return null;
    }
  }
}
