import 'package:flutter/material.dart';

class CustomTextButtonYellow extends StatelessWidget {
  final String textoBotao;
  final VoidCallback onPressed;
  final double? width;
  final double? heigth;

  const CustomTextButtonYellow({
    required this.textoBotao,
    required this.onPressed,
    this.width,
    this.heigth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: heigth != null ? double?.parse(heigth.toString()) : 52,
        width: width != null ? double?.parse(width.toString()) : 300,
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            textoBotao,
            style: const TextStyle(
              color: Color.fromARGB(255, 83, 5, 64),
            ),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(15),
            backgroundColor: const Color.fromARGB(255, 254, 220, 86),
            side: const BorderSide(
              color: Color.fromARGB(255, 83, 5, 64),
              width: 2,
              style: BorderStyle.solid,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
