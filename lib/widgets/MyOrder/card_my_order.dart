import 'dart:ui';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

import 'package:pointsf/widgets/export_widgets.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';

class CardMyOrder extends StatelessWidget {
  final order;

  const CardMyOrder({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(25, 10, 10, 10),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                  width: 3,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  style: BorderStyle.solid,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              // height: 125,
              child: TextButton(
                onPressed: () => showBarModalBottomSheet(
                  context: context,
                  builder: (context) => MyOrderModal(
                    order: order,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "id - ${order["uid"]}",
                            style: const TextStyle(
                              color: Color.fromARGB(100, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat("dd/MM/yy")
                                  .format(order["data"].toDate()),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            Text(
                              UtilBrasilFields.obterReal(
                                order["valorTotalProdutos"] +
                                    order["taxaEntrega"],
                              ),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${order["endereco"]}, ${order["numero"]}, ${order["bairro"]}",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                        child: order["status"] == "recusado"
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cancel_rounded,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    "Seu pedido foi cancelado",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              )
                            : Container(
                                margin: EdgeInsets.fromLTRB(0, 13, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.bookmark_add_outlined,
                                          color: Color.fromARGB(255, 0, 100, 0),
                                        ),
                                        Text(
                                          DateFormat("HH:mm")
                                              .format(order["data"].toDate()),
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 100, 0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    order["pedidoAceito"] != null
                                        ? const Expanded(
                                            child: LinearProgressIndicator(
                                              color: Color.fromARGB(
                                                  255, 74, 44, 82),
                                              backgroundColor: Color.fromARGB(
                                                  100, 74, 44, 82),
                                              value: 1,
                                            ),
                                          )
                                        : const Expanded(
                                            child: LinearProgressIndicator(
                                              color: Color.fromARGB(
                                                  255, 74, 44, 82),
                                              backgroundColor: Color.fromARGB(
                                                  100, 74, 44, 82),
                                            ),
                                          ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    order["pedidoAceito"] != null
                                        ? Row(
                                            children: [
                                              const Icon(
                                                Icons.verified_outlined,
                                                color: Color.fromARGB(
                                                    255, 0, 100, 0),
                                              ),
                                              Text(
                                                order["pedidoAceito"] != null
                                                    ? DateFormat("HH:mm")
                                                        .format(order[
                                                                "pedidoAceito"]
                                                            .toDate())
                                                    : "xx:xx",
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 100, 0),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              const Icon(
                                                Icons.verified_outlined,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                              Text(
                                                order["pedidoAceito"] != null
                                                    ? DateFormat("HH:mm")
                                                        .format(order[
                                                                "pedidoAceito"]
                                                            .toDate())
                                                    : "xx:xx",
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ),
                                            ],
                                          ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    order["pedidoAceito"] != null
                                        ? order["pedidoConcluido"] != null
                                            ? const Expanded(
                                                child: LinearProgressIndicator(
                                                  color: Color.fromARGB(
                                                      255, 74, 44, 82),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          100, 74, 44, 82),
                                                  value: 1,
                                                ),
                                              )
                                            : const Expanded(
                                                child: LinearProgressIndicator(
                                                  color: Color.fromARGB(
                                                      255, 74, 44, 82),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          100, 74, 44, 82),
                                                ),
                                              )
                                        : Expanded(
                                            child: Container(),
                                          ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    order["pedidoAceito"] != null
                                        ? order["pedidoConcluido"] != null
                                            ? Row(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .delivery_dining_outlined,
                                                    color: Color.fromARGB(
                                                        255, 0, 100, 0),
                                                  ),
                                                  Text(
                                                    order["pedidoConcluido"] !=
                                                            null
                                                        ? DateFormat("HH:mm")
                                                            .format(order[
                                                                    "pedidoConcluido"]
                                                                .toDate())
                                                        : "xx:xx",
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 100, 0),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .delivery_dining_outlined,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  ),
                                                  Text(
                                                    order["pedidoConcluido"] !=
                                                            null
                                                        ? DateFormat("HH:mm")
                                                            .format(order[
                                                                    "pedidoConcluido"]
                                                                .toDate())
                                                        : "xx:xx",
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                    ),
                                                  )
                                                ],
                                              )
                                        : Row(
                                            children: [
                                              const Icon(
                                                Icons.delivery_dining_outlined,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                              Text(
                                                order["pedidoConcluido"] != null
                                                    ? DateFormat("HH:mm").format(
                                                        order["pedidoConcluido"]
                                                            .toDate())
                                                    : "xx:xx",
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              )
                                            ],
                                          ),
                                  ],
                                ),
                              )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      color: const Color.fromARGB(255, 240, 240, 240),
    );
  }
}
