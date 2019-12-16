// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

/// An example of using the plugin, controlling lifecycle and playback of the
/// video.

import 'package:flutter/cupertino.dart';
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

void main() {
  runApp(
    MaterialApp(
      home: VideoWidget(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    ),
  );
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
          width: 100,
          height: 200,
          child: Stack(children: [
            Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: VideoPlayer(controller),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (isPaused) {
                  controller.play();
                  isPaused = false;
                } else {
                  controller.pause();
                  isPaused = true;
                }
              },
            ),
          ]),
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
