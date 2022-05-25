import 'package:flutter/material.dart';

class ControllerException implements Exception {
  String message;
  ControllerException(this.message);
}

class AddressControllerService extends TextEditingController {
  String? page;
  TextEditingController? cep;
  TextEditingController? city;
  TextEditingController? complement;
  TextEditingController? district;
  TextEditingController? name;
  TextEditingController? number;
  TextEditingController? street;

  AddressControllerService() {
    _addressControllerService();
  }

  _addressControllerService() {
    cep = TextEditingController();
    city = TextEditingController();
    complement = TextEditingController();
    district = TextEditingController();
    name = TextEditingController();
    number = TextEditingController();
    street = TextEditingController();
  }

  setValue(result) {
    if (result.logradouro != "") {
      street = TextEditingController(text: result.logradouro);
    } else {
      street = TextEditingController(text: "");
    }

    if (result.complemento != "") {
      complement = TextEditingController(text: result.complemento);
    } else {
      complement = TextEditingController(text: "");
    }

    if (result.bairro != "") {
      district = TextEditingController(text: result.bairro);
    } else {
      district = TextEditingController(text: "");
    }

    if (result.cidade != "") {
      city = TextEditingController(text: result.cidade);
    } else {
      city = TextEditingController(text: "");
    }
  }
}
