import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_modeling_ui/state.dart';
import 'package:software_modeling_ui/urls.dart';
import 'package:software_modeling_ui/video_player.dart';

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your collection"),
      ),
      body: Builder(
        builder: (context) => Consumer<AppState>(
          builder: (_, state, __) => GridView.count(
              crossAxisCount: 8,
              children: List.generate(libraryURls.length, (index) {
                return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (ctxt) => new AlertDialog(
                                title: _buildVideoDialog(context),
                              ));
                    },
                    child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            child: Card(
                              color: Colors.grey[800],
                              child: Image.network(
                                    libraryURls[index],
                                    fit: BoxFit.contain,
                                  ) ??
                                  Image.network(
                                      "https://cdn.pixabay.com/photo/2013/07/12/12/58/tv-test-pattern-146649_960_720.png"),
                            ),
                          ),
                          Icon(
                            Icons.favorite,
                            size: 70,
                          )
                        ]));
              })),
        ),
      ),
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
            Navigator.of(context).pop();
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text(
                "Video downloaded",
                style: TextStyle(fontSize: 30, color: Colors.lightGreen),
              ),
            ));
          },
        )
      ],
    );
  }
}
