import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    consumerKey: Secretes.consumerApiKey,
    consumerSecret: Secretes.consumerApiSecret,
    token: Secretes.accessToken,
    tokenSecret: Secretes.accessTokenSecret,
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
    Firestore.instance.collection('twitter_accounts').getDocuments().then((value) {
      Global.allTwitterHandles.clear();
      value.documents.forEach((element) {
        Global.allTwitterHandles.add(element["handle"]);
      });
      getTweets();
    });
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
    debugPrint("Twitter handles " + query);
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
    debugPrint(res.statusCode);
    if (res.statusCode == 200) {
      var tweets = json.decode(res.body);
      debugPrint(tweets["statuses"].length);
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
