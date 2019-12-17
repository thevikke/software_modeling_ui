// VideoWidget(
//               'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/scheduler.dart';

typedef Widget VideoWidgetBuilder(
    BuildContext context, VideoPlayerController controller);

abstract class PlayerLifeCycle extends StatefulWidget {
  PlayerLifeCycle(this.dataSource, this.childBuilder);

  final VideoWidgetBuilder childBuilder;
  final String dataSource;
}

class VideoWidget extends StatelessWidget {
  VideoWidget(this.videoURL);
  final String videoURL;

  @override
  Widget build(BuildContext context) {
    return NetworkPlayerLifeCycle(
      videoURL,
      (BuildContext context, VideoPlayerController controller) =>
          AspectRatioVideo(controller),
    );
  }
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      if (!mounted) {
        return;
      }
      if (initialized != controller.value.initialized) {
        initialized = controller.value.initialized;
        setState(() {});
      }
    };
    controller.addListener(listener);
  }

  bool isPaused = true;
  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.height / 1.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: VideoPlayer(controller),
                ),
              ),
              isPaused
                  ? IconButton(
                      icon: Icon(Icons.play_arrow),
                      iconSize: 50,
                      onPressed: () {
                        controller.play();
                        setState(() {
                          isPaused = false;
                        });
                      },
                    )
                  : IconButton(
                      onPressed: () {
                        controller.pause();
                        setState(() {
                          isPaused = true;
                        });
                      },
                      icon: Icon(Icons.pause),
                    ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

/// A widget connecting its life cycle to a [VideoPlayerController] using
/// a data source from the network.
class NetworkPlayerLifeCycle extends PlayerLifeCycle {
  NetworkPlayerLifeCycle(String dataSource, VideoWidgetBuilder childBuilder)
      : super(dataSource, childBuilder);

  @override
  _NetworkPlayerLifeCycleState createState() => _NetworkPlayerLifeCycleState();
}

abstract class _PlayerLifeCycleState extends State<PlayerLifeCycle> {
  VideoPlayerController controller;

  /// Subclasses should implement [createVideoPlayerController], which is used
  /// by this method.
  @override
  void initState() {
    super.initState();
    controller = createVideoPlayerController();
    controller.addListener(() {
      if (controller.value.hasError) {
        print(controller.value.errorDescription);
      }
    });
    controller.initialize();
    controller.setVolume(0.0);
    controller.setLooping(true);
    // controller.play();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.childBuilder(context, controller);
  }

  VideoPlayerController createVideoPlayerController();
}

class _NetworkPlayerLifeCycleState extends _PlayerLifeCycleState {
  @override
  VideoPlayerController createVideoPlayerController() {
    return VideoPlayerController.network(widget.dataSource);
  }
}

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}
