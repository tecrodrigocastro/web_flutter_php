import 'package:flutter/material.dart';
import 'package:web_flutter_php/screens/dashboard_screen.dart';
import 'package:web_flutter_php/screens/edit_product_screen.dart';
import 'package:web_flutter_php/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard Web',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const LoginScreen(),
      routes: {
        DashboardScreen.routeName: (_) => const DashboardScreen(),
        EditProduct.routeName: (_) => const EditProduct(),
      },
    );
  }
}
