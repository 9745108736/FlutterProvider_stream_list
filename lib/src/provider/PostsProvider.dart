import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tp_connects/src/models/core/ListPostModel.dart';
import 'package:tp_connects/src/models/glitch/glitch.dart';
import 'package:tp_connects/src/models/helper/listPostHelper.dart';

class PostsProvider extends ChangeNotifier {
  final _helper = ListPostsHelper();
  final _streamController = StreamController<Either<Glitch, ListPostModel>>();

  Stream<Either<Glitch, ListPostModel>> get loginResStream {
    return _streamController.stream;
  }

  Future<void> getPosts({int pageNo}) async {
    final loginRes = await _helper.getPostList(page: pageNo);
    _streamController.add(loginRes);
  }
}
