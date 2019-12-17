import 'dart:math';

import 'package:flutter/material.dart';
import 'package:software_modeling_ui/video_player.dart';

import 'urls.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<String> list = List<String>();
  @override
  void initState() {
    list.addAll(movieURls);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage content"),
        actions: <Widget>[],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            IconButton(
              iconSize: 70,
              onPressed: () {
                final _random = new Random();
                var element = list[_random.nextInt(movieURls.length)];
                setState(() {
                  list.insert(0, element);
                });
              },
              icon: Icon(Icons.add),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 1.3,
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) => Card(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image.network(
                        list[index],
                        fit: BoxFit.fill,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            iconSize: 200,
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                list.removeAt(index);
                              });
                            },
                          ),
                          IconButton(
                            iconSize: 200,
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (ctxt) => new AlertDialog(
                                        title: _buildVideoDialog(context),
                                      ));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoDialog(BuildContext context) {
    String value = "Choose access type";
    return Column(
      children: <Widget>[
        Stack(children: [
          VideoWidget(
              "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
          DropdownButton<String>(
            hint: Text(value),
            items: <String>["Free user", "Paid user"].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                value = newValue;
              });
            },
          ),
        ]),
      ],
    );
  }
}
