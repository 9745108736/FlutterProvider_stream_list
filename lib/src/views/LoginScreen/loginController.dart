import 'package:flutter/material.dart';
import 'package:tp_connects/src/getIt.dart';
import 'package:tp_connects/src/provider/LoginProvider.dart';

class LoginController
{
  TextEditingController phoneTC = new TextEditingController();
  TextEditingController passwordTC = new TextEditingController();
  String phoneErrTxt = "";
  String passwordErrTxt = "";
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  bool showLoading = false;
  final provider = getIt<LoginProvider>();
  String loginErrorMessage = "";


}