import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utilities/globals.dart';

class YoutubePlayerScreen extends StatefulWidget {
  YoutubePlayerScreen({this.title, this.videoId});
  final String videoId;
  final String title;
  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController _webViewController;

  String strHtml;
  String videoId;
  String title;

  void reload() {
    if (_webViewController != null) {
      _webViewController.reload();
    }
  }

  @override
  void initState() {
    super.initState();
    videoId = widget.videoId;
    if (videoId == null) {
      videoId = "";
    }
    title = widget.title;
    if (title == null) {
      title = 'Harmony Video';
    }
    strHtml = '''
<!DOCTYPE html>
<html>
<head>
    <style type="text/css">
    .video-container {
    overflow: hidden;
    position: relative;
    width:100%;
}

.video-container::after {
    padding-top: 56.25%;
    display: block;
    content: '';
}

.video-container iframe {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}
    </style>
</head>
  <body>
    <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
    <div id="player"></div>
<div class="video-container">
  <iframe src="https://www.youtube.com/embed/$videoId" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>    
  </body>
</html>
''';
  }

  @override
  Widget build(BuildContext context) {
    Global.checkIfDarkModeEnabled(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
        initialUrl: "about:blank",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
          _loadHtmlFromString();
          _controller.complete(webViewController);
        },
      ),
    );
  }

  _loadHtmlFromString() {
    _webViewController.loadUrl(Uri.dataFromString(strHtml, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
  }
}
