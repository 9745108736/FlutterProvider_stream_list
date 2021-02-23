import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:tp_connects/src/models/core/LoginModel.dart';
import 'package:tp_connects/src/models/glitch/NoInternetGlitch.dart';
import 'package:tp_connects/src/models/glitch/glitch.dart';
import 'package:tp_connects/src/models/service/ApiService.dart';

class LoginHelper {
  final api = ApiService();

  Future<Either<Glitch, LoginResponseModel>> loginMethod(
      {String phone, String password}) async {
    Map<String, dynamic> loginBodyParam = {
      "phone": phone,
      "password": password,
      "device_os": Platform.isAndroid ? "Android" : "Ios",
      "device_token": "123456",
      "device_id": "123456"
    };
    final apiResult =
        await api.postApiRequest(url: "signin", bodyParam: loginBodyParam);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      print(r);
      final photo = LoginResponseModel.fromJson(jsonDecode(r));
      print(photo.userToken);
      return Right(photo);
    });
  }
}
