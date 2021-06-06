import 'package:flutter/material.dart';
import 'dart:io';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int port = 0;
  String ipv4 = "";

  final portController = TextEditingController();
  final ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter IPv4 Address and TCP Port"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "IP Address: ",
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 50)),
                    child: TextFormField(
                      controller: ipController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter IP Address'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Port: ",
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 50)),
                    child: TextFormField(
                      controller: portController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Port number'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 80,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  port = int.parse(portController.text);
                  ipv4 = ipController.text;
                  Navigator.pushReplacementNamed(
                    context,
                    '/mainscreen',
                    arguments: {"socket": Socket.connect(ipv4, port)},
                  );
                },
                child: Text("Connect"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
