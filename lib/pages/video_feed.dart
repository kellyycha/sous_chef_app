import 'package:flutter/material.dart';
import 'package:stream_video/stream_video.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              iconSize: 35,
              color: Colors.black,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(1),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 20),

          // TODO: Stream video (kelly's task)
          
          // StreamVideo(
          //   streamUrl: 'YOUR_VIDEO_STREAM_URL_HERE',
          //   aspectRatio: 16 / 9, // Adjust according to your video stream aspect ratio
          // ),
          Container(
            height: 400,
            padding:EdgeInsets.all(30),
            alignment: Alignment.center,
            child: const Text(
              'Camera is not active.',
              style: TextStyle(
                color:Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

          ),
        ],
      ),
    );
  }
}