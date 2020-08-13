import 'dart:convert';

import 'package:HarmonyHub/components/video_list_item.dart';
import 'package:HarmonyHub/screens/info_screen.dart';
import 'package:HarmonyHub/youtube_api/youtube_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/resuable_card.dart';
import '../utilities/constants.dart';
import '../utilities/globals.dart';
import '../utilities/secretes.dart';

class VideosFeedScreen extends StatefulWidget {
  @override
  _VideosFeedScreenState createState() => _VideosFeedScreenState();
}

class _VideosFeedScreenState extends State<VideosFeedScreen> {
  bool dataLoading = false;
  List<Widget> youtubeItems = new List<Widget>();
  YoutubeAPI ytApi = new YoutubeAPI(Secretes.youtubeAccessKey);
  List<YT_API> videoFeed = new List<YT_API>();

  Future<void> callYoutubeAPI() async {
    videoFeed = await ytApi.channel(Global.harmonyYoutubeChannelId);
    refreshData();
  }

  Future<void> refreshData() async {
    List<Widget> videos = new List<Widget>();
    for (int i = 0; i < videoFeed.length; i++) {
      YT_API feed = videoFeed[i];
      String title = utf8.decode(utf8.encode(feed.title));
      String description = utf8.decode(utf8.encode(feed.description));
      //print(feed.url);
      //print(feed.thumbnail);
      VideoListViewItem item = VideoListViewItem(
        height: description.length < 75 ? 80 : 135,
        title: title,
        text: description,
        leading: feed.thumbnail["default"]["url"] == null
            ? Icon(
                FontAwesomeIcons.youtube,
                size: 40,
              )
            : Image.network(
                feed.thumbnail["default"]["url"],
              ),
        moreDetails: true,
        openMoreDetails: () {
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => YoutubePlayerScreen(
                title: feed.title,
                videoId: feed.id,
              ),
            ),
          );*/
          print(feed.url);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InformationScreen(
                title: feed.title,
                url: "https://www.youtube.com/watch?v=${feed.id}",
              ),
            ),
          );
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
    callYoutubeAPI();
  }

  @override
  Widget build(BuildContext context) {
    Global.checkIfDarkModeEnabled(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: callYoutubeAPI,
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
