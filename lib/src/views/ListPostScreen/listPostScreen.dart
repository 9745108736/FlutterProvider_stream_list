import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:tp_connects/src/constents/colors.dart';
import 'package:tp_connects/src/constents/strings.dart';
import 'package:tp_connects/src/getIt.dart';
import 'package:tp_connects/src/models/core/ListPostModel.dart';
import 'package:tp_connects/src/utils/findUtils.dart';
import 'package:tp_connects/src/utils/utils.dart';
import 'package:tp_connects/src/views/ListPostScreen/ListPostController.dart';
import 'package:tp_connects/src/views/LoginScreen/LoginScreen.dart';
import 'package:tp_connects/src/views/ListPostScreen/video_item.dart';
import 'package:tp_connects/src/widgets/commonWidget.dart';
import 'package:tp_connects/src/widgets/loadingWidget.dart';
import 'package:tp_connects/src/views/PostDetailPage/postDetailPage.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ListPostsScreen extends StatefulWidget {
  @override
  _ListPostsScreenState createState() => _ListPostsScreenState();
}

ListPostController _listPostController = new ListPostController();

class _ListPostsScreenState extends State<ListPostsScreen>
    with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
          backgroundColor: MyColors.appBackgroundColor.redC,
          body: _body(),
          floatingActionButton: InkWell(
            onTap: () {
              FindUtils.sharePref.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Icon(Icons.logout),
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _checkToken();
    _listPostController.pageNumber = 1;
    _listPostController.scrollController = new ScrollController();
    _listPostController.scrollController.addListener(() {
      if (_listPostController.scrollController.position.pixels ==
          _listPostController.scrollController.position.maxScrollExtent) {
        _listPostController.pageNumber += 1;
        _getPosts(page: _listPostController.pageNumber);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _listPostController.scrollController.dispose();
  }

  _checkToken() async {
    var token = await FindUtils.sharePref.getTokenOnly();
    print("token - $token");
    if (token == null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  // ListPostModel listPostModel;

  _getPosts({int page}) {
    _listPostController.provider.getPosts(pageNo: page ?? 1);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _getPosts(page: 1);
    _listPostController.provider.loginResStream.listen((snapshot) {
      snapshot.fold(
          (l) => {
                print("Somthing went wrong - ${l.message}"),
                FailedToastWidget(context, message: l.message),
                LoadingManege(manageLoading: false),
              },
          (r) => {
                if (r.status == true)
                  {
                    print("r.data.length - ${r.data.length}"),
                    print("Post List Success"),
                    if (r.data.length != 0)
                      {
                        _listPostController.postList.addAll(r.data),
                      },
                    print(_listPostController.postList.length),
                    LoadingManege(manageLoading: false),
                  }
              });
    });
  }

  LoadingManege({bool manageLoading}) {
    _listPostController.showLoading =
        manageLoading ?? !_listPostController.showLoading;
    setState(() {});
  }

  Widget _body() {
    return Center(
      child: Card(
        child: Container(
          color: MyColors.white.redC,
          height: MediaQuery.of(context).size.height + 10,
          width: MediaQuery.of(context).size.width - 30,
          child: _listPostController.showLoading == true
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: RoundedLoadingButtonWidget(
                        color: MyColors.btnGreenColor.redC,
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  controller: _listPostController.scrollController,
                  itemBuilder: (context, index) {
                    return singlePostWidget(
                        context: context,
                        data: _listPostController.postList[index],
                        fn: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostDetailScreen(
                                      data: _listPostController.postList[index],
                                    )),
                          );
                        });
                  },
                  itemCount: _listPostController.postList.length,
                ),
        ),
      ),
    );
  }
}

Widget singlePostWidget(
    {PostListData data,
    double imgSize,
    BoxFit boxFit,
    Function fn,
    @required context}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        ListTile(
          leading: ClipOval(
            child: Image.network(
              data.details.image,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: data?.details?.name ?? "",
                  children: [
                    TextSpan(
                      text: data?.location?.address ?? "",
                      style: FindUtils.MyStyles.styleLight(fontSize: 16),
                    ),
                  ],
                  style: FindUtils.MyStyles.styleBold(fontSize: 16),
                ),
                textAlign: TextAlign.center,
              ),
              Text(Utils.convertDateTime(dT: data?.postDate.toString())),
            ],
          ),
          trailing: Icon(Icons.more_horiz),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 10, right: 10, bottom: 20),
          child: Row(
            children: [
              data.postType == TypeOfPost.text
                  ? Container()
                  : Text(
                      "${data?.content ?? ""}",
                      maxLines: 2,
                    ),
            ],
          ),
        ),
        data.postType == TypeOfPost.text
            ? Container(
                decoration: BoxDecoration(
                    color: MyColors.textPostColor.redC,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: MediaQuery.of(context).size.width / 1.3,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    data?.content ?? "",
                    // "asdjflkjaflkajsldkfjlkasdjfklajsfdlkjaslkdfjlkasjdflkasdjflkjsdaflkjasdlkfjasdlkfjasldkfjsldkjflsdjflsdjflsadjf \nasdlkfjaslkdfjasdfjsdflkj\nasdjlkasjf",
                    style: FindUtils.MyStyles.styleLight(
                        fontSize: 16, fontColor: MyColors.txtblue.redC),
                  ),
                ))
            : data?.postType == TypeOfPost.photo //TODO:change not
                ? InkWell(
                    onTap: () {
                      fn();
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        height: imgSize ?? 250,
                        child: Stack(
                          children: [
                            PinchZoom(
                              zoomedBackgroundColor:
                                  Colors.black.withOpacity(0.5),
                              resetDuration: const Duration(milliseconds: 100),
                              maxScale: 2.5,
                              image: CachedNetworkImage(
                                imageUrl: data.image,
                                fit: boxFit ?? BoxFit.cover,
                                placeholder:
                                    (BuildContext context, String url) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                },
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Positioned(
                              child: Align(
                                alignment: FractionalOffset.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.account_circle_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              child: Align(
                                alignment: FractionalOffset.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      fn();
                    },
                    child: Container(
                      height: 350,
                      child: VideoItems(
                        videoPlayerController: VideoPlayerController.network(
                          // data?.video,
                          "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
                        ),
                        looping: true,
                        autoplay: false,
                      ),
                    ),
                  ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  data?.myReact == null
                      ? Icon(Icons.thumb_up_alt_outlined)
                      : Text(
                          "${data?.myReact ?? ""}",
                          style: TextStyle(fontSize: 20),
                        ),
                  spaceWidthWidget(sizeParam: 10),
                  _postedLikedPersonWidget(data: data),
                ],
              ),
              Row(
                children: [
                  Text("${data.comments ?? ""}"),
                  spaceWidthWidget(sizeParam: 5),
                  Icon(Icons.message),
                  spaceWidthWidget(sizeParam: 15),
                  Text("20"),
                  spaceWidthWidget(sizeParam: 5),
                  Icon(Icons.share)
                ],
              )
            ],
          ),
        ),
        spaceHeightWidget(sizeParam: 20),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // spaceWidthWidget(sizeParam: 10),
              Text("view all ${data.comments} comments"),
              data.postType == TypeOfPost.text
                  ? Container()
                  : InkWell(
                      onTap: () {
                        data.postType == TypeOfPost.video
                            ? _downLoadModule(task: data.video)
                            : _downLoadModule(task: data.image);
                        // _downLoadVide(task:"https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4");
                      },
                      child: Icon(Icons.download_rounded))
            ],
          ),
        ),
        spaceHeightWidget(sizeParam: 20),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Container(
            height: 45,
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MyColors.appBackgroundColor.redC,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusColor: MyColors.appBackgroundColor.redC,
                  fillColor: MyColors.appBackgroundColor.redC,
                  hintText: L.writeCommentStr,
                  filled: true),
            ),
          ),
        )
      ],
    ),
  );
}

Future<String> _findLocalPath() async {
  final directory = Platform.isAndroid == TargetPlatform.android
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();
  return directory.path;
}

void _downLoadModule({String task}) async {
  _listPostController.localPath =
      (await _findLocalPath()) + Platform.pathSeparator + 'Download';

  final savedDir = Directory(_listPostController.localPath);
  bool hasExisted = await savedDir.exists();
  if (!hasExisted) {
    savedDir.create();
  }
  await FlutterDownloader.enqueue(
      url: task,
      // headers: {"auth": "test_for_sql_encoding"},
      savedDir: _listPostController.localPath,
      showNotification: true,
      openFileFromNotification: true);
}

Widget _postedLikedPersonWidget({PostListData data}) {
  return Row(
    children: [
      Container(
        width: 40,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: data.reactDetails.length >= 3
              ? Stack(
                  children: [
                    _commentOvalImg(imgUrl: data?.reactDetails[0]),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: _commentOvalImg(imgUrl: data?.reactDetails[1]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: _commentOvalImg(imgUrl: data?.reactDetails[2]),
                    )
                  ],
                )
              : data.reactDetails.length == 1
                  ? Stack(
                      children: [
                        _commentOvalImg(imgUrl: data?.reactDetails[0])
                      ],
                    )
                  : data.reactDetails.length == 0
                      ? Container()
                      : Stack(
                          children: [
                            _commentOvalImg(imgUrl: data?.reactDetails[0]),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 10),
                              child: _commentOvalImg(
                                  imgUrl: data?.reactDetails[1]),
                            )
                          ],
                        ),
        ),
      ),
      spaceWidthWidget(sizeParam: 5),
      Text("${data.reactDetails.length} Others")
    ],
  );
}

Widget _commentOvalImg({String imgUrl}) {
  return ClipOval(
    child: Image.network(
      imgUrl,
      height: 20,
      width: 20,
      fit: BoxFit.cover,
    ),
  );
}
