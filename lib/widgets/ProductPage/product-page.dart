import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pointsf/Services/ProductService/product-service.dart';

class ProductPage extends StatelessWidget {
  final String? category;

  const ProductPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: ProductService().getActiveProductsByCategory(category),
              builder: (_, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                      height: 57,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(50, 10, 10, 10),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Color.fromARGB(255, 255, 217, 65),
                      ),
                      child: TextButton(
                        child: Text(
                          snapshot.data!.docs[index]["nome"],
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          print(snapshot.data!.docs[index]["uid"]);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      color: const Color.fromARGB(255, 254, 220, 86),
    );
  }
}
