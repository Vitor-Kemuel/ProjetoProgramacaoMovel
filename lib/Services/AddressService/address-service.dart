import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pointsf/Services/AuthService/auth-service.dart';
import 'package:pointsf/models/address-model.dart';
import 'package:pointsf/View/export-all-view.dart';

import 'package:uuid/uuid.dart';

class AddressException implements Exception {
  String message;
  AddressException(this.message);
}

class AddressService extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;

  registration(AddressModel model, BuildContext context) {
    var uuid = const Uuid();
    var uid = uuid.v1();
    try {
      firestore
          .collection('usuarios')
          .doc(AuthService().getUid())
          .collection("enderecos")
          .doc(uid)
          .set({
        "cep": model.cep,
        "logradouro": model.logradouro,
        "numero": model.numero,
        "complemento": model.complemento,
        "bairro": model.bairro,
        "cidade": model.cidade,
        "uid": uid,
      });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ListAddress(),
      ),
    );
  }

  getAddress() {
    return firestore
        .collection("usuarios")
        .doc(AuthService().getUid())
        .collection("enderecos")
        .snapshots();
  }
}