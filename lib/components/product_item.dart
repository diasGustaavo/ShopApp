import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCTS_FORM,
                  arguments: product,
                );
              },
              color: Theme.of(context).colorScheme.primary,
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                final retornoDialog = showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Tem certeza?'),
                    content: Text('Quer remover produto?'),
                    actions: [
                      TextButton(
                        child: Text('Não'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      TextButton(
                        child: Text('Sim'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  ),
                );
                retornoDialog.then((value) {
                  if (value!) {
                    Provider.of<ProductList>(
                      context,
                      listen: false,
                    ).removeProduct(product);
                  }
                });
              },
              color: Theme.of(context).errorColor,
              icon: Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}
