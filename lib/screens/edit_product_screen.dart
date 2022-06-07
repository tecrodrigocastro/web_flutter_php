import 'package:flutter/material.dart';
import 'package:web_flutter_php/screens/login_screen.dart';

class EditProduct extends StatefulWidget {
  static const routeName = '/edit_product';
  const EditProduct({Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('seller.name!'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      // drawer: customDrawer(seller),
    );
  }
}
