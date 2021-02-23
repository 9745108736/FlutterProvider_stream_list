import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tp_connects/src/models/core/ListPostModel.dart';
import 'package:tp_connects/src/models/glitch/NoInternetGlitch.dart';
import 'package:tp_connects/src/models/glitch/glitch.dart';
import 'package:tp_connects/src/models/service/ApiService.dart';
import 'package:tp_connects/src/utils/findUtils.dart';

class ListPostsHelper {
  final api = ApiService();

  Future<Either<Glitch, ListPostModel>> getPostList({int page}) async {
    var _token = await FindUtils.sharePref.getTokenOnly();
    final apiResult = await api.getApiRequest(
        url:
            "http://13.235.24.93:3300/postslist?user_token=$_token&page=$page");
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      print(r);
      final photo = ListPostModel.fromJson(jsonDecode(r));
      // if (photo.data.length != 0)
      return Right(photo);
      // else
      // return null;
    });
  }
}
