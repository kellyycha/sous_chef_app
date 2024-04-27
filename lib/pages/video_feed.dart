import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('http://10.0.0.250:4000')); // 172.26.3.177
  }

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
          const Spacer(),
          isLoading?
          const Row(
            children: [
              Spacer(),
              Icon(
                Icons.videocam_outlined,
                size: 40,
              ),
              Text(
                'Live Video Feed',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                ),
              ),
              Spacer(),
            ]
          )
          : const Center(
            child: Text(
              'Camera disconnected',
              style: TextStyle(
                fontSize: 28,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            height: 400,
            width: 400,
            child: Stack(
              children: [
                WebViewWidget(controller: controller),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
