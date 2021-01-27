import 'dart:async';
import 'dart:io';

import 'package:HarmonyHub/utilities/scrolling_gesture_recognizer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utilities/globals.dart';

class InformationScreen extends StatefulWidget {
  InformationScreen({this.title, this.url, this.showAppIcon});
  final String url;
  final String title;
  final bool showAppIcon;
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController _webViewController;

  String url;
  String title;
  bool showAppIcon = false;

  void reload() {
    if (_webViewController != null) {
      _webViewController.reload();
    }
  }

  @override
  void initState() {
    super.initState();
    url = widget.url;
    if (url == null) {
      url = "https://harmony.one";
    }
    title = widget.title;
    if (title == null) {
      title = 'Information';
    }
    if (widget.showAppIcon != null) {
      showAppIcon = widget.showAppIcon;
    }
  }

  @override
  Widget build(BuildContext context) {
    Global.checkIfDarkModeEnabled(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: showAppIcon
            ? ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  'assets/app_icon.png',
                ),
              )
            : null,
      ),
      body: WebView(
          initialUrl: url,
          userAgent:
              "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController = webViewController;
            _controller.complete(webViewController);
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains("https://m.youtube.com/") && request.url.contains("noapp=1")) {
              _webViewController.loadUrl(this.url);
              if (Platform.isAndroid) {
                return NavigationDecision.navigate;
              } else if (Platform.isIOS) {
                return NavigationDecision.prevent;
              }
            }
            return NavigationDecision.navigate;
          },
          gestureRecognizers: [
            Factory(() => PlatformViewVerticalGestureRecognizer()),
          ].toSet()),
    );
  }
}
