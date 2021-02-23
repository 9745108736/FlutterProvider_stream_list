import 'package:flutter/material.dart';
import 'package:tp_connects/src/constents/colors.dart';
import 'package:tp_connects/src/utils/findUtils.dart';
import 'package:tp_connects/src/views/LoginScreen/LoginScreen.dart';
import 'package:tp_connects/src/widgets/loadingWidget.dart';
import 'package:web_socket_channel/io.dart';

import 'ListPostScreen/listPostScreen.dart';
import 'ListPostScreen/socketScreenTest.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  _checkToken() async {
    var token = await FindUtils.sharePref.getTokenOnly();
    print("token - $token");
    if (token != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ListPostsScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.appBackgroundColor.redC,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: RoundedLoadingButtonWidget(
                color: MyColors.btnGreenColor.redC,
              ),
            ),
          ],
        ));
  }
}
