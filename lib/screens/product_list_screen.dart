import 'package:crud_example/models/product.dart';
import 'package:crud_example/providers/auth_provider.dart';
import 'package:crud_example/providers/product_provider.dart';
import 'package:crud_example/screens/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  Future<void> _signOut(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.signOut();
    Navigator.pushReplacementNamed(context, '/sign-in');
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = Provider.of<ProductProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => _signOut(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Logout ', style: TextStyle(color: Colors.white)),
                Icon(Icons.logout, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productProvider.products.length,
          itemBuilder: (context, index) {
            final product = productProvider.products[index];
            return productItem(product, context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-product');
        },
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget productItem(Product product, BuildContext context) {
  void _deleteProduct() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Product'),
          content: Text(
            'Are you sure you want to delete this product ${product.name}?',
          ),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                final productProvider = Provider.of<ProductProvider>(
                  context,
                  listen: false,
                );
                await productProvider.deleteProduct(product.id!);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  return Card(
    elevation: 2,
    color: Colors.white,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            width: 90,
            height: 90,
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Category: ${product.category}',
                style: TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Price: \$${product.price}',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    UpdateProductScreen(product: product),
                          ),
                        ),
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.amber),
                        Text(' Edit', style: TextStyle(color: Colors.amber)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => _deleteProduct(),
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        Text(' Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
