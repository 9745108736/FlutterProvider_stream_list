import 'package:flutter/material.dart';
import 'package:tp_connects/src/views/LoginScreen/LoginScreen.dart';
import 'package:web_socket_channel/io.dart';

import 'ListPostScreen/listPostScreen.dart';
import 'ListPostScreen/socketScreenTest.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: LoginScreen(),
      body: ListPostsScreen(),
      // body: SocketScreen(),
    );
  }
}
