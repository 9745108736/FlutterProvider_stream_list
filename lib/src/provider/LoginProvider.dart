import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:tp_connects/src/models/core/LoginModel.dart';
import 'package:tp_connects/src/models/glitch/glitch.dart';
import 'package:tp_connects/src/models/helper/LoginHelper.dart';

class LoginProvider extends ChangeNotifier {
  final _helper = LoginHelper();//login helper
  final _streamController =
      StreamController<Either<Glitch, LoginResponseModel>>(); //login method stream controller,

  Stream<Either<Glitch, LoginResponseModel>> get loginResStream {
    return _streamController.stream;
  }

  Future<void> login({String usrName, passWrd}) async {
    final loginRes =
        await _helper.loginMethod(password: passWrd, phone: usrName);
    _streamController.add(loginRes);
  }
}
