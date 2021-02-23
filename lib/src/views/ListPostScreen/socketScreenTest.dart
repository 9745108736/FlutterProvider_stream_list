import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tp_connects/src/constents/colors.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketScreen extends StatefulWidget {
  // final String title;
  // final WebSocketChannel schannel;
  //
  // SocketScreen({Key key, @required this.title, @required this.channel})
  //     : super(key: key);

  @override
  _SocketScreenState createState() => _SocketScreenState();
}

class _SocketScreenState extends State<SocketScreen> {
  TextEditingController _controller = TextEditingController();
  WebSocketChannel schannel =
      IOWebSocketChannel.connect('ws://13.235.24.93:8895');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white.redC,
      appBar: AppBar(
        title: Text("Socket demo"),
        backgroundColor: MyColors.white.redC,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
              stream: schannel.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      Map<String, dynamic> loginBodyParam = {
        "authorization": "12345",
        "user_token":
            "eccbc87e4b5ce2fe28308fd9f2a7baf3::4a25b114fd02d75543f567e133896888::123456",
        "sender": {
          "id": 10,
          "image":
              "https://pv-staging.s3.ap-south- 1.amazonaws.com/profile/jpg/0.16333144993145088.png"
        },
        "ref_id": "327",
        "react": "",
        "request": "post",
        "type": "react"
      };
      schannel.sink.add(json.encode(loginBodyParam));
      // widget.channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    schannel.sink.close();
    super.dispose();
  }
}
