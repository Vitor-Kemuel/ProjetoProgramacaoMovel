import 'package:flutter/material.dart';

import 'package:pointsf/Services/CartService/cart_service.dart';
import 'package:pointsf/View/Cart/cart.dart';
import 'package:pointsf/widgets/export_widgets.dart';

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> cartItens;
  final int index;
  final CartService cartService = CartService();

  CartItemCard({
    Key? key,
    required this.cartItens,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 225, 225, 225),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 5, 0, 30),
                  child: Text(
                    cartItens["quantidade"].toString() + "x",
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          cartItens["produto"] +
                              ", " +
                              cartItens['size'] +
                              " - " +
                              cartItens['preco'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      RenderAdditional(
                        cartItensAdditional: cartItens["adicionais"],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                cartService.removeItemFromCard(cartItens["uid"]);
                cartItens.remove(index);
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const Cart()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
