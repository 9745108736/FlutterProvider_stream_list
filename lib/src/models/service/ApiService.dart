import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:tp_connects/src/models/core/LoginModel.dart';

class ApiService {
  String endpoint = "http://65.0.127.170/wp-json/wp/v2/"; //base url

  Future<Either<Exception, String>> getApiRequest({String url}) async {
    //get api method only end point need to send
    try {
      print(url);
      final response = await http.get(url);
      print(response.body);
      return Right(response.body);
    } catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, String>> postApiRequest({
    String url,
    Map<String, dynamic> bodyParam,
  }) async {//Post api call need to pass url endPoint with body parameter
    try {
      print(endpoint + url);
      final response = await http.post(
        endpoint + url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(bodyParam),
      );
      print(response.body);
      return Right(response.body);
    } catch (e) {
      return (Left(e));
    }
  }
}
