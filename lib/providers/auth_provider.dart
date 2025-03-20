import 'package:crud_example/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _currentUser;

  User? get currentUser => _currentUser;

  AuthProvider() {
    fetchUser();
  }

  Future<void> fetchUser() async {
    _authService.authStateChanges.listen((user) {
      _currentUser = user;
      notifyListeners();
    });
  }

  Future<User?> signIn(String email, String password) async => _authService.signIn(email, password);

  Future<User?> signUp(String email, String password) async => _authService.signUp(email, password);

  Future<void> signOut() async => _authService.signOut();

}