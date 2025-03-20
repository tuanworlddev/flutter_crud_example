import 'package:crud_example/firebase_options.dart';
import 'package:crud_example/providers/auth_provider.dart';
import 'package:crud_example/providers/product_provider.dart';
import 'package:crud_example/screens/add_product_screen.dart';
import 'package:crud_example/screens/auth_wrapper.dart';
import 'package:crud_example/screens/sign_in_screen.dart';
import 'package:crud_example/screens/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade100,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade600),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade600,
          foregroundColor: Colors.white,
        ),
      ),
      routes: {
        '/': (context) => const AuthWrapper(),
        '/sign-in': (context) => const SignInScreen(),
        '/sign-up': (context) => const SignUpScreen(),
        '/add-product': (context) => const AddProductScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

