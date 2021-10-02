import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunbox/prefabs/estilo.dart';

class Button {
  static Widget buttonMenu({@required onPressed, text, height, width}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          backgroundColor: Estilo.corSecundaria,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          )),
      child: text ?? null,
    );
  }
}
