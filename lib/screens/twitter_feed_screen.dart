import 'package:HarmonyHub/screens/twitter_filter_screen.dart';
import 'package:HarmonyHub/services/twitterservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/resuable_card.dart';
import '../models/twitter_feed.dart';
import '../utilities/constants.dart';
import '../utilities/globals.dart';

class TwitterFeedScreen extends StatefulWidget {
  @override
  _TwitterFeedScreenState createState() => _TwitterFeedScreenState();
}

class _TwitterFeedScreenState extends State<TwitterFeedScreen> {
  final twitterService = TwitterService();
  bool dataLoading = false;
  List<Widget> twitterItems = new List<Widget>();
  List<TwitterFeed> tweetFeed = new List<TwitterFeed>();
  @override
  void initState() {
    super.initState();
    getTweets();
  }

  Future<void> getTweets() async {
    setState(() {
      dataLoading = true;
    });
    List<Widget> tweets = await twitterService.getTweets(context);
    setState(() {
      twitterItems = tweets;
      dataLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Global.checkIfDarkModeEnabled(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tweets'),
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
                  builder: (context) => TwitterFilterScreen(
                    refreshTweets: getTweets,
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
      body: dataLoading
          ? SpinKitDoubleBounce(
              color: Colors.grey,
              size: 50.0,
            )
          : Container(
              child: RefreshIndicator(
                onRefresh: getTweets,
                child: ListView(
                  padding: const EdgeInsets.all(5),
                  children: <Widget>[
                    ReusableCard(
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: twitterItems,
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
