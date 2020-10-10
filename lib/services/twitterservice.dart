import 'dart:convert';

import 'package:HarmonyHub/components/list_view_item.dart';
import 'package:HarmonyHub/models/twitter_feed.dart';
import 'package:HarmonyHub/screens/info_screen.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:HarmonyHub/utilities/secretes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:twitter_api/twitter_api.dart';

class TwitterService {
  final _twitterOauth = new twitterApi(
    consumerKey: Secretes.twitterConsumerApiKey,
    consumerSecret: Secretes.twitterConsumerApiSecret,
    token: Secretes.twitterAccessToken,
    tokenSecret: Secretes.twitterAccessTokenSecret,
  );
  List<Widget> twitterItems = new List<Widget>();
  List<TwitterFeed> tweetFeed = new List<TwitterFeed>();

  Future<List<Widget>> getTweets(BuildContext context) async {
    await Global.getInitializer();
    List<String> twitterHandles = await Global.getUserFavList(Global.favoriteTwitterHandlesKey);
    if (twitterHandles == null || twitterHandles.length == 0) {
      Global.allTwitterHandles.add("stse");
      Global.allTwitterHandles.add("nickwh8te");
      Global.allTwitterHandles.add("SahilDewan");
      Global.allTwitterHandles.add("GIZEMCAKIL");
      Global.allTwitterHandles.add("harmonyprotocol");
      Global.setUserFavList(Global.favoriteTwitterHandlesKey, Global.allTwitterHandles);
      return await getTweetsData(context);
    } else {
      Global.allTwitterHandles = twitterHandles;
      return await getTweetsData(context);
    }
  }

  Future<List<Widget>> getTweetsData(BuildContext context) async {
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
    DateFormat dateFormat = new DateFormat("E MMM d H:m:s y");
// Print off the response
    if (res.statusCode == 200) {
      tweetFeed.clear();
      var tweets = json.decode(res.body);
      for (int i = 0; i < tweets["statuses"].length; i++) {
        var status = tweets["statuses"][i];
        String dateString = (status["created_at"]).toString().replaceAll("+0000 ", "");
        TwitterFeed feed = new TwitterFeed(
          userName: status["user"]["name"],
          tweetText: status["text"],
          tweetId: status["id"],
          userId: status["user"]["screen_name"],
          profilePicURL: status["user"]["profile_image_url_https"],
          dateTime: dateFormat.parse(dateString),
        );
        tweetFeed.add(feed);
      }
    }
    query = Global.twitterTweetQuery;
    twitterRequest = _twitterOauth.getTwitterRequest(
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

    res = await twitterRequest;
    if (res.statusCode == 200) {
      var tweets = json.decode(res.body);
      for (int i = 0; i < tweets["statuses"].length; i++) {
        var status = tweets["statuses"][i];
        String dateString = (status["created_at"]).toString().replaceAll("+0000 ", "");
        String userName = status["user"]["name"];
        bool isRetweet = (status["in_reply_to_status_id_str"]).toString() == "null" ? false : true;
        if (!isRetweet) {
          isRetweet = status['retweeted_status'] == null ? false : true;
        }
        if (Global.allTwitterHandles.indexOf(userName) == -1 && !isRetweet) {
          TwitterFeed feed = new TwitterFeed(
            userName: userName,
            tweetText: status["text"],
            tweetId: status["id"],
            userId: status["user"]["screen_name"],
            profilePicURL: status["user"]["profile_image_url_https"],
            dateTime: dateFormat.parse(dateString),
          );
          if (tweetFeed.indexOf(feed) == -1) {
            tweetFeed.add(feed);
          }
        }
      }
    }
    tweetFeed.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return await createTweetList(context);
  }

  Future<List<Widget>> createTweetList(BuildContext context) async {
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
    return tweets;
  }
}
