import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'iconToastWidget.dart';

//common height sized box
Widget spaceHeightWidget({double sizeParam}) {
  return SizedBox(
    height: sizeParam ?? 70,
  );
}

Widget spaceWidthWidget({double sizeParam}) {
  return SizedBox(
    width: sizeParam ?? 70,
  );
}

//success toast
Widget SuccessToastWidget(context, {@required String message}) {
  showToastWidget(IconToastWidget.success(msg: message ?? 'success'),
      context: context,
      position: StyledToastPosition.bottom,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      duration: Duration(seconds: 1),
      animDuration: Duration(microseconds: 500),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear);
}
Widget FailedToastWidget(context, {@required String message}) {
  showToastWidget(IconToastWidget.fail(msg: message ?? 'Failed'),
      context: context,
      position: StyledToastPosition.center,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      duration: Duration(seconds: 4),
      animDuration: Duration(seconds: 1),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear);
}