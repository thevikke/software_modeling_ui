// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

/// An example of using the plugin, controlling lifecycle and playback of the
/// video.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_modeling_ui/library_page.dart';
import 'package:software_modeling_ui/start_page.dart';
import 'package:software_modeling_ui/urls.dart';
import 'items_list.dart';

import 'state.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          home: StartPage()),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<AppState>(
        builder: (_, state, __) => Scaffold(
          appBar: AppBar(
            title: _headerItems(state, context),
            actions: <Widget>[],
          ),
          drawer: Drawer(
            child: state.userType != USER_TYPE.OLD_USER
                ? Container()
                : _drawerItems(context, state),
          ),
          body: ItemsList(
            items: _listItems(state.selectedList),
          ),
        ),
      ),
    );
  }

  List<String> _listItems(SELECTED_LIST listType) {
    if (listType == SELECTED_LIST.Movies) {
      return movieURls;
    } else if (listType == SELECTED_LIST.Music) {
      return musicURLs;
    } else {
      return bookURLs;
    }
  }

  Widget _drawerItems(BuildContext context, AppState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LibraryPage()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.favorite),
              SizedBox(
                width: 5,
              ),
              Text("Your collection"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _headerItems(AppState state, BuildContext context) {
    String title = "";
    if (state.selectedList == SELECTED_LIST.Movies) {
      title = "Movies";
    } else if (state.selectedList == SELECTED_LIST.Music) {
      title = "Music ";
    } else {
      title = "Books ";
    }
    return Row(
      children: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: <Widget>[
              Icon(Icons.backspace),
              SizedBox(
                width: 5,
              ),
              Text("Back"),
            ],
          ),
        ),
        // FlatButton(
        //   onPressed: () {
        //     state.changeList(SELECTED_LIST.Books);
        //   },
        //   child: Row(
        //     children: <Widget>[
        //       Icon(Icons.book),
        //       SizedBox(
        //         width: 5,
        //       ),
        //       Text("Books"),
        //     ],
        //   ),
        // ),
        // FlatButton(
        //   onPressed: () {
        //     state.changeList(SELECTED_LIST.Music);
        //   },
        //   child: Row(
        //     children: <Widget>[
        //       Icon(Icons.music_note),
        //       SizedBox(
        //         width: 5,
        //       ),
        //       Text("Music"),
        //     ],
        //   ),
        // ),
        FlatButton(
          onPressed: () {
            state.changeList(SELECTED_LIST.Movies);
          },
          child: Row(
            children: <Widget>[
              Icon(Icons.movie),
              SizedBox(
                width: 5,
              ),
              Text("Movies"),
            ],
          ),
        ),
        SizedBox(
          width: 100,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.lightGreen, fontSize: 120),
        ),
        SizedBox(
          width: 50,
        ),
      ],
    );
  }
}
