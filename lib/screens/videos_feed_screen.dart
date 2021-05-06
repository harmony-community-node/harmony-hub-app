import 'dart:convert';
import 'dart:io';

import 'package:HarmonyHub/components/video_list_item.dart';
import 'package:HarmonyHub/models/video_sources.dart';
import 'package:HarmonyHub/screens/info_screen.dart';
import 'package:HarmonyHub/screens/video_filter_screen.dart';
import 'package:HarmonyHub/services/video_source_service.dart';
import 'package:HarmonyHub/youtube_api/youtube_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/resuable_card.dart';
import '../utilities/constants.dart';
import '../utilities/globals.dart';
import '../utilities/secretes.dart';

class VideosFeedScreen extends StatefulWidget {
  VideosFeedScreen({Key key}) : super(key: key);
  @override
  _VideosFeedScreenState createState() => _VideosFeedScreenState();
  static final GlobalKey<_VideosFeedScreenState> videoFeedScreenKey = GlobalKey<_VideosFeedScreenState>();
  void refreshVideos() {
    videoFeedScreenKey.currentState.getVideos();
  }
}

class _VideosFeedScreenState extends State<VideosFeedScreen> {
  bool dataLoading = false;
  List<Widget> youtubeItems = [];
  YoutubeAPI ytApi = new YoutubeAPI(Secretes.youtubeAccessKey);
  List<YT_API> videoFeed = [];
  VideoSourceService vSourceService = new VideoSourceService();

  Future<void> getVideos() async {
    List<Widget> videos = [];
    List<VideoSource> vSource = await vSourceService.getVideoSources();
    for (int i = 0; i < vSource.length; i++) {
      VideoSource feed = vSource[i];
      String title = utf8.decode(utf8.encode(feed.title));
      String description = utf8.decode(utf8.encode(feed.description));
      //print(feed.url);
      //print(feed.thumbnail);
      VideoListViewItem item = VideoListViewItem(
        height: description.length < 75 ? 80 : 135,
        title: title,
        text: description,
        leading: feed.thumbnailURL == null
            ? Icon(
                FontAwesomeIcons.youtube,
                size: 40,
              )
            : Image.network(
                feed.thumbnailURL,
              ),
        moreDetails: true,
        openMoreDetails: () async {
          if (Platform.isIOS) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InformationScreen(
                  title: feed.title,
                  url: feed.videoUrl,
                ),
              ),
            );
          } else {
            String url = feed.videoUrl;
            await canLaunch(url) ? await launch(url) : print('Could not launch $url');
          }
        },
      );
      videos.add(item);
      SizedBox sb = SizedBox(height: 3);
      videos.add(sb);
    }
    setState(() {
      youtubeItems = videos;
    });
  }

  @override
  void initState() {
    super.initState();
    getVideos();
  }

  @override
  Widget build(BuildContext context) {
    Global.checkIfDarkModeEnabled(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Image.asset(
            'assets/app_icon.png',
          ),
        ),
        actions: [
          new IconButton(
            icon: Icon(FontAwesomeIcons.filter),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoFilterScreen(
                    refreshVideos: getVideos,
                  ),
                ),
              );
            },
          ),
        ],
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: getVideos,
          child: ListView(
            padding: const EdgeInsets.all(5),
            children: <Widget>[
              ReusableCard(
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: youtubeItems,
                ),
                colour: kHmyMainColor.withAlpha(20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
