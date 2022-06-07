import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_flutter_php/api/server.dart';
import 'package:web_flutter_php/models/product.dart';
import 'package:web_flutter_php/screens/edit_product_screen.dart';
import 'package:web_flutter_php/utils/config.dart';

class ProductList extends StatelessWidget {
  final Product product;
  final int productIndex;
  const ProductList(
      {Key? key, required this.product, required this.productIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(Configuracao().config);
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'http://${Configuracao().config}/backend_flutter_php/assets/${product.image}'),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  product.name!,
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 50),
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(text: 'R\$ '),
                        TextSpan(text: product.pricePerKg.toString())
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print('Clicou no editar');
                    Navigator.of(context).popAndPushNamed(
                      EditProduct.routeName,
                      arguments: product.id,
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.deepPurple,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print('Clicou no deletar');
                    Server()
                        .deleteProductPerId(product.id!)
                        .then((value) => print(value))
                        .catchError((e) => print(e));
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
