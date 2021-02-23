import 'package:flutter/material.dart';

import 'colors.dart';
import 'fonts.dart';

class Mystyles {
  TextStyle styleNormal({@required double fontSize, Color fontColor}) =>
      TextStyle(
          color: fontColor ?? MyColors.black.redC,
          fontFamily: MyFonts.FontRegular.fontC,
          fontSize: fontSize);

  TextStyle styleLight({@required double fontSize, Color fontColor}) =>
      TextStyle(
          color: fontColor ?? MyColors.black.redC,
          fontFamily: MyFonts.FontLight.fontC,
          fontSize: fontSize);

  TextStyle styleBold({@required double fontSize, Color fontColor}) =>
      TextStyle(
          color: fontColor ?? MyColors.black.redC,
          fontFamily: MyFonts.FontBold.fontC,
          fontSize: fontSize);
}
