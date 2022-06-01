import 'package:flutter/material.dart';

import 'package:pointsf/Services/CartService/cart_service.dart';
import 'package:pointsf/widgets/export_widgets.dart';

class CartPage extends StatefulWidget {
  var cartItens;

  CartPage({
    Key? key,
    this.cartItens,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartService cartService = CartService();
  @override
  void initState() {
    super.initState();
    setCart();
  }

  Future<void> setCart() async {
    await cartService.setCart();
    setState(() {
      widget.cartItens = cartService.cartItens;
    });
  }

  @override
  Widget build(BuildContext context) {
    while (widget.cartItens == null) {
      setCart();
      return ListView(
        children: [
          Column(
            children: const [
              SizedBox(
                height: 300,
              ),
              CircularProgressIndicator(),
            ],
          ),
        ],
      );
    }
    return Container(
      color: const Color.fromARGB(0, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Seus produtos:",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.cartItens[0] == null
                    ? Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                Icons.remove_shopping_cart_outlined,
                                size: 100,
                                color: Color.fromARGB(150, 0, 0, 0),
                              ),
                              Text(
                                "Seu carrinho está vazio!",
                                style: TextStyle(
                                  color: Color.fromARGB(150, 0, 0, 0),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: CartList(
                          cartItens: widget.cartItens,
                        ),
                      ),
              ],
            ),
          ),
          Column(
            children: [
              CustomTextButton(
                buttonText: "Finalizar",
                onPressed: () {
                  if (widget.cartItens[0] != null) {
                    Navigator.of(context).pushNamed(
                      '/confirmationInformation',
                      arguments: {'items': widget.cartItens},
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("O carrinho está vazio"),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
