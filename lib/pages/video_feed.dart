import 'package:flutter/material.dart';
import 'package:stream_video/stream_video.dart';

class VideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            iconSize: 35,
            color: Colors.black,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(1),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous page
            },
          ),
          const SizedBox(height: 20),
          // StreamVideo(
          //   streamUrl: 'YOUR_VIDEO_STREAM_URL_HERE',
          //   aspectRatio: 16 / 9, // Adjust according to your video stream aspect ratio
          // ),

        ],
      ),
    );
  }
}