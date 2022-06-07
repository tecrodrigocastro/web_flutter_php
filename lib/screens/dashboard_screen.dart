import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_flutter_php/api/server.dart';
import 'package:web_flutter_php/models/product.dart';
import 'package:web_flutter_php/models/seller.dart';
import 'package:web_flutter_php/screens/login_screen.dart';
import 'package:web_flutter_php/widgets/custom_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:web_flutter_php/widgets/product_list.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController description = TextEditingController();
  List<Product> _products = [];
  bool _firstExec = true;
  bool _isEdit = false;

  void getProductsPerSeller(int sellerId) {
    Server()
        .getProductsPerSeller(sellerId)
        .then((value) => {
              print(value),
              setState(() {
                _products = value;
              }),
            })
        .catchError((e) => print(e));
  }

  @override
  void initState() {
    super.initState();
  }

  //Future<Seller>? seller;
  @override
  Widget build(BuildContext context) {
    Seller seller = ModalRoute.of(context)!.settings.arguments as Seller;

    if (_firstExec) {
      getProductsPerSeller(seller.id!);
      _firstExec = false;
    }

    void cadastrar() {
      Server()
          .cadProduct(
            name: name.text,
            sellerId: seller.id.toString(),
            price: price.text,
            description: description.text,
            image: seller.image!,
          )
          // ignore: avoid_print
          .then((value) => print(value))
          .catchError((e) => print(e));
    }

    void limparCampos() {
      name.clear();
      price.clear();
      image.clear();
      description.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(seller.name!),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: customDrawer(seller),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.deepPurple,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.65,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 20,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "CADASTRAR PRODUTO",
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              formfield(title: 'Nome', controller: name),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Imagem')),
                              const SizedBox(height: 10),
                              formfield(title: 'Preço', controller: price),
                              const SizedBox(height: 10),
                              formfield(
                                  title: 'Descrição',
                                  controller: description,
                                  desc: true,
                                  n: 4),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: const Center(
                                    child: Text("CADASTRAR"),
                                  ),
                                ),
                                onPressed: () {
                                  cadastrar();
                                  limparCampos();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurple,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.65,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Text(
                              'LISTA DE PRODUTOS',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: ListView.builder(
                                itemCount: _products.length,
                                itemBuilder: (((context, index) => ProductList(
                                      product: _products[index],
                                      productIndex: index,
                                    ))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formfield({
    required String title,
    required TextEditingController controller,
    int? n,
    bool desc = false,
  }) {
    return TextField(
      maxLines: desc ? n : 1,
      controller: controller,
      decoration: InputDecoration(
        hintText: title,
        filled: true,
        fillColor: Colors.blueGrey[50],
        labelStyle: const TextStyle(fontSize: 12),
        contentPadding: const EdgeInsets.only(left: 30, top: 10),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey.shade50),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey.shade50),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
