import 'package:flutter/material.dart';

class RenderAdditionalOrder extends StatelessWidget {
  final Map<int, dynamic> orderItensAdditional;

  const RenderAdditionalOrder({
    Key? key,
    required this.orderItensAdditional,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 15, 10),
      shrinkWrap: true,
      itemCount: orderItensAdditional.length,
      itemBuilder: (_, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "${orderItensAdditional[index]["adicional"]}",
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  " R\$ ${orderItensAdditional[index]["preco"]}",
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
