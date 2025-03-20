import 'package:crud_example/providers/auth_provider.dart';
import 'package:crud_example/screens/product_list_screen.dart';
import 'package:crud_example/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({ super.key });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final currentUser = authProvider.currentUser;

    if (currentUser == null) {
      return const SignInScreen();
    }

    return const ProductListScreen();
  }
}