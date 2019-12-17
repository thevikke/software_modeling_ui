import 'dart:math';

import 'package:flutter/material.dart';
import 'urls.dart';

class AdManagerPage extends StatefulWidget {
  @override
  _AdManagerPageState createState() => _AdManagerPageState();
}

class _AdManagerPageState extends State<AdManagerPage> {
  List<String> list = List<String>();
  @override
  void initState() {
    list.addAll(adURls);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage ads"),
        actions: <Widget>[],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            IconButton(
              iconSize: 70,
              onPressed: () {
                final _random = new Random();
                var element = list[_random.nextInt(adURls.length)];
                setState(() {
                  list.insert(0, element);
                });
              },
              icon: Icon(Icons.add),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 1.5,
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) => Card(
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        list[index],
                        fit: BoxFit.fill,
                      ),
                      Center(
                        child: IconButton(
                          iconSize: 70,
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              list.removeAt(index);
                            });
                          },
                        ),
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
}
