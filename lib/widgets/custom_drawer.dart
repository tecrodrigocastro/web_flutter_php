import 'package:flutter/material.dart';
import 'package:web_flutter_php/models/seller.dart';

Widget customDrawer(Seller seller) {
  return Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(seller.name!),
          accountEmail: Text(seller.email!),
          currentAccountPicture: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
                "http://192.168.100.151/backend_flutter_php/assets/${seller.image}"),
          ),
        ),
        ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text("Adicionar Produto"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              debugPrint('toquei no cadastrar');
            }),
        ListTile(
            leading: const Icon(Icons.list),
            title: const Text("Lista de Produtos"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              debugPrint('toquei no listar');
            }),
      ],
    ),
  );
}
