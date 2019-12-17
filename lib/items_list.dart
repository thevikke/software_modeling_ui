import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_modeling_ui/state.dart';
import 'package:software_modeling_ui/video_player.dart';

class ItemsList extends StatefulWidget {
  ItemsList({Key key, this.items}) : super(key: key);
  final List<String> items;

  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  final _random = new Random();
  List<int> randomNumberList = List<int>();

  @override
  void initState() {
    widget.items.forEach((_) {
      randomNumberList.add(_random.nextInt(5));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, state, __) => GridView.count(
          crossAxisCount: 8,
          children: List.generate(widget.items.length, (index) {
            return InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctxt) => new AlertDialog(
                            title: _buildDialog(
                                context, state, randomNumberList[index]),
                          ));
                },
                child: randomNumberList[index] == 1 &&
                        (state.userType == USER_TYPE.NO_ACCOUNT ||
                            state.userType == USER_TYPE.OLD_USER)
                    ? Stack(children: [
                        Center(
                          child: Container(
                            child: Card(
                              color: Colors.grey[800],
                              child: Image.network(
                                    widget.items[index],
                                    fit: BoxFit.contain,
                                  ) ??
                                  Image.network(
                                      "https://cdn.pixabay.com/photo/2013/07/12/12/58/tv-test-pattern-146649_960_720.png"),
                            ),
                          ),
                        ),
                        Center(
                          child: Icon(
                            Icons.lock,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                      ])
                    : Container(
                        child: Card(
                          color: Colors.grey[800],
                          child: Image.network(
                                widget.items[index],
                                fit: BoxFit.contain,
                              ) ??
                              Image.network(
                                  "https://cdn.pixabay.com/photo/2013/07/12/12/58/tv-test-pattern-146649_960_720.png"),
                        ),
                      ));
          })),
    );
  }

  Widget _buildDialog(BuildContext context, AppState state, int randomNumber) {
    if ((state.userType == USER_TYPE.NO_ACCOUNT ||
            state.userType == USER_TYPE.OLD_USER) &&
        randomNumber == 1) {
      return _buildPayingDialog();
    } else {
      return _buildVideoDialog(context);
    }
  }

  Widget _buildPayingDialog() {
    return Row(
      children: <Widget>[
        FlatButton(
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (ctxt) => new AlertDialog(
                        title: _buildVideoDialog(context),
                      ));
            });
          },
          child: Row(
            children: <Widget>[
              Icon(Icons.attach_money),
              SizedBox(
                width: 5,
              ),
              Text("Buy now to see once"),
            ],
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (ctxt) => new AlertDialog(
                      title: _buildVideoDialog(context),
                    ));
          },
          child: Row(
            children: <Widget>[
              Icon(Icons.subscriptions),
              SizedBox(
                width: 5,
              ),
              Text("Subscribe to watch everything"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVideoDialog(BuildContext context) {
    return Column(
      children: <Widget>[
        VideoWidget(
            "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
        IconButton(
          iconSize: 50,
          icon: Icon(Icons.cloud_download),
          onPressed: () {
            Scaffold.of(context).showSnackBar(SnackBar(
              action: SnackBarAction(
                label: 'OK',
                textColor: Colors.white,
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
              backgroundColor: Colors.black,
              content: Text(
                "Video downloaded!",
                style: TextStyle(fontSize: 30, color: Colors.lightGreen),
              ),
            ));
          },
        )
      ],
    );
  }
}
