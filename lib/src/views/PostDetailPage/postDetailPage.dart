import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:tp_connects/src/constents/colors.dart';
import 'package:tp_connects/src/models/core/ListPostModel.dart';
import 'package:tp_connects/src/utils/findUtils.dart';
import 'package:tp_connects/src/utils/utils.dart';
import 'package:tp_connects/src/views/ListPostScreen/listPostScreen.dart';

class PostDetailScreen extends StatefulWidget {
  PostListData data;

  PostDetailScreen({this.data});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.white.redC,
          elevation: 0.0,
        ),
        backgroundColor: MyColors.white.redC,
        body: _body(),
      ),
    );
  }



  _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          singlePostWidget(context: context,
              data: widget.data,
              imgSize: MediaQuery.of(context).size.width,
              boxFit: BoxFit.contain),
        ],
      ),
    );
  }
}
