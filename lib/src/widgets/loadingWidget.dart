import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tp_connects/src/constents/colors.dart';


//loading
Widget RoundedLoadingButtonWidget({Color color}) {
  return Container(
    height: 30,
    width: 30,
    child: LoadingIndicator(
      indicatorType: Indicator.ballTrianglePath,
      color: color ?? MyColors.black,
    ),
  );
}
