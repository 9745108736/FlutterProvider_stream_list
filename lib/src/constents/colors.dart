import 'package:flutter/material.dart';

enum MyColors {
  appBackgroundColor,
  red,
  black,
  txtblue,
  white,
  underLineColor,
  btnGreenColor,
  textPostColor
}

extension colorExten on MyColors {
  Color get redC {
    switch (this) {
      case MyColors.red:
        return Colors.red;
        break;
      case MyColors.white:
        return Colors.white;
        break;
      case MyColors.txtblue:
        return Colors.blue.shade500;
        break;
      case MyColors.black:
        return Colors.black;
        break;
      case MyColors.underLineColor:
        return Colors.grey;
        break;
      //#1da95a
      case MyColors.btnGreenColor:
        return HexColor(hexColor: "#1da95a");
        break;
      case MyColors.appBackgroundColor:
        return HexColor(hexColor: "#e5e5e5");
        break;
      case MyColors.textPostColor:
        return HexColor(hexColor: "#efefff");
        break;
      case MyColors.txtblue:
        return HexColor(hexColor: "#3b4991");
        break;
        //#3b4991
      //#efefff
      default:
        break;
    }
  }
}

class HexColor extends Color {
  HexColor({final String hexColor}) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
