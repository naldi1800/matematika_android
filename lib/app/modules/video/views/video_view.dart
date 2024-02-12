import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';

import 'package:get/get.dart';
import 'package:matematika/app/util/ui.dart';

import '../controllers/video_controller.dart';

class VideoView extends GetView<VideoController> {
  const VideoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Materi',
            style: TextStyle(color: UI.action),
          ),
          iconTheme: IconThemeData(color: UI.action),
          backgroundColor: UI.foreground,
          // actions: [
          //   IconButton(
          //       onPressed: () => Get.back(),
          //       icon: const Icon(
          //         Icons.arrow_back,
          //         color: UI.action,
          //       ))
          // ],
        ),
        backgroundColor: UI.backgroud,
        body: Column(
          children: [
            GetBuilder<VideoController>(
              init: VideoController(),
              builder: (c) => Expanded(
                child: c.chewieController != null &&
                        c.chewieController!.videoPlayerController.value
                            .isInitialized
                    ? Chewie(controller: c.chewieController!)
                    : const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text(
                              'Loading',
                              style: TextStyle(fontSize: 15, color: UI.action),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ));
  }
}
