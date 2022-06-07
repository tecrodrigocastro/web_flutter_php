import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:web_flutter_php/models/product.dart';
import 'package:web_flutter_php/models/seller.dart';
import 'package:http/http.dart' as http;

class Server {
  final String _baseUrl = 'http://192.168.100.151/backend_flutter_php/api';

  Future<Seller> loginPost(
      {required String email, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/seller/login'),
        body: {'email': email, 'password': password},
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return Seller.fromMap(json.decode(response.body)['seller']);
    } catch (e) {
      // ignore: prefer_interpolation_to_compose_strings, avoid_print
      print('Server Handler : error : ' + e.toString());
      // ignore: use_rethrow_when_possible
      rethrow;
    }
  }

  //CADASTRAR PROUTOS
  cadProduct({
    required String name,
    required String sellerId,
    String? image,
    required String price,
    required String description,
    int? interaction,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/seller/add'),
        body: {
          'seller_id': sellerId,
          'name': name,
          'price_per_kg': price,
          'description': description,
          'image': image
        },
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return response.statusCode;
    } catch (e) {
      // ignore: prefer_interpolation_to_compose_strings, avoid_print
      print('Server Handler : error : ' + e.toString());
      // ignore: use_rethrow_when_possible
      rethrow;
    }
  }

  //LISTA DE PRODUTOS
  Future<List<Product>> getProductsPerSeller(int sellerId) async {
    try {
      List<Product> products = [];

      http.Response response = await http
          .get(Uri.parse('$_baseUrl/gen/products?seller_id=$sellerId'));

      //print(response.body);

      List productList = (json.decode(response.body))['products'];

      for (Map m in productList) {
        products.add(Product.fromMap(m));
      }

      return products;
    } catch (e) {
      // ignore: prefer_interpolation_to_compose_strings, avoid_print
      print('Server Handler : error : ' + e.toString());
      // ignore: use_rethrow_when_possible
      rethrow;
    }
  }

  deleteProductPerId(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/seller/delete_product.php?product_id=$id'),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.statusCode;
    } catch (e) {
      // ignore: prefer_interpolation_to_compose_strings, avoid_print
      print('Server Handler : error : ' + e.toString());
      // ignore: use_rethrow_when_possible
      rethrow;
    }
  }
}
