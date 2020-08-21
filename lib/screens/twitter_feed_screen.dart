import 'dart:convert';

import 'package:HarmonyHub/screens/twitter_filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_api/twitter_api.dart';

import '../components/list_view_item.dart';
import '../components/resuable_card.dart';
import '../models/twitter_feed.dart';
import '../screens/info_screen.dart';
import '../utilities/constants.dart';
import '../utilities/globals.dart';
import '../utilities/secretes.dart';

class TwitterFeedScreen extends StatefulWidget {
  @override
  _TwitterFeedScreenState createState() => _TwitterFeedScreenState();
}

class _TwitterFeedScreenState extends State<TwitterFeedScreen> {
  final _twitterOauth = new twitterApi(
    consumerKey: Secretes.twitterConsumerApiKey,
    consumerSecret: Secretes.twitterConsumerApiSecret,
    token: Secretes.twitterAccessToken,
    tokenSecret: Secretes.twitterAccessTokenSecret,
  );

  bool dataLoading = false;
  List<Widget> twitterItems = new List<Widget>();
  List<TwitterFeed> tweetFeed = new List<TwitterFeed>();
  @override
  void initState() {
    super.initState();
    getTwitterHandles();
  }

  Future<void> getTwitterHandles() async {
    setState(() {
      dataLoading = true;
    });
    List<String> twitterHandles = await Global.getUserFavList(Global.favoriteTwitterHandlesKey);
    print(twitterHandles);
    if (twitterHandles == null || twitterHandles.length == 0) {
      Global.allTwitterHandles.add("stse");
      Global.allTwitterHandles.add("nickwh8te");
      Global.allTwitterHandles.add("SahilDewan");
      Global.allTwitterHandles.add("GIZEMCAKIL");
      Global.allTwitterHandles.add("harmonyprotocol");
      Global.setUserFavList(Global.favoriteTwitterHandlesKey, Global.allTwitterHandles);
      getTweets();
    } else {
      Global.allTwitterHandles = twitterHandles;
      getTweets();
    }
  }

  Future<void> getTweets() async {
    String query = "";
    for (int i = 0; i < Global.allTwitterHandles.length; i++) {
      String handle = Global.allTwitterHandles[i];
      query = "$query from:@$handle";
      if ((i + 1) < Global.allTwitterHandles.length) {
        query = "$query OR ";
      }
    }
    Future twitterRequest = _twitterOauth.getTwitterRequest(
      // Http Method
      "GET",
      // Endpoint you are trying to reach
      "search/tweets.json",
      // The options for the request
      options: {
        "q": query,
        "count": "100",
        "result_type": "recent",
      },
    );

// Wait for the future to finish
    var res = await twitterRequest;

// Print off the response
    if (res.statusCode == 200) {
      tweetFeed.clear();
      var tweets = json.decode(res.body);
      for (int i = 0; i < tweets["statuses"].length; i++) {
        var status = tweets["statuses"][i];
        TwitterFeed feed = new TwitterFeed(
          userName: status["user"]["name"],
          tweetText: status["text"],
          tweetId: status["id"],
          userId: status["user"]["screen_name"],
          profilePicURL: status["user"]["profile_image_url_https"],
        );
        tweetFeed.add(feed);
      }
    }
    refreshData();
  }

  Future<void> refreshData() async {
    List<Widget> tweets = new List<Widget>();
    for (int i = 0; i < tweetFeed.length; i++) {
      TwitterFeed feed = tweetFeed[i];
      ListViewItem item = ListViewItem(
        height: feed.tweetText.length < 75 ? 80 : 125,
        title: feed.userName,
        text: feed.tweetText,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: feed.profilePicURL == null
              ? Icon(
                  FontAwesomeIcons.twitter,
                  size: 40,
                )
              : Image.network(
                  feed.profilePicURL,
                ),
        ),
        moreDetails: true,
        openMoreDetails: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InformationScreen(
                title: "Harmonious News Release",
                url: "https://twitter.com/${feed.userId}/status/${feed.tweetId}",
              ),
            ),
          );
        },
      );
      tweets.add(item);
      SizedBox sb = SizedBox(height: 3);
      tweets.add(sb);
    }
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
        actions: [
          new IconButton(
            icon: Icon(FontAwesomeIcons.filter),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TwitterFilterScreen(
                    refreshTweets: getTwitterHandles,
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
                onRefresh: getTwitterHandles,
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
