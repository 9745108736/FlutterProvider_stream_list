import 'package:flutter/material.dart';
import 'package:tp_connects/src/models/core/ListPostModel.dart';
import 'package:tp_connects/src/provider/PostsProvider.dart';

import '../../getIt.dart';

class ListPostController{
  bool showLoadMore = true;
  int pageNumber;
  final provider = getIt<PostsProvider>();
  ScrollController scrollController;
  List<PostListData> postList = List<PostListData>();
  bool showLoading = true;
  String localPath;


}