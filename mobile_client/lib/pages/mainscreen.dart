import 'package:flutter/material.dart';
import 'dart:convert' show utf8;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Map data = {};
  Future socket;

  int textLength = 0;
  String text = "";
  String format = "utf-8";
  int header = 64;

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    socket = data["socket"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Input Text"),
      ),
      body: SizedBox.expand(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(200, 50)),
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter text',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 80,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    text = textController.text;
                    textLength = text.length;
                    var textLengthMsg = utf8.encode(textLength.toString());

                    // List<int> padding = [];
                    // for (var i = 0; i < (header - textLengthMsg.length); i++) {
                    //   padding += utf8.encode(" ");
                    // }

                    // textLengthMsg += padding;
                    //socket.then((socket) => socket.write(textLengthMsg));
                    socket.then((socket) => socket.write(text));
                  },
                  child: Text("Send"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
