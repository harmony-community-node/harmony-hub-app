import 'package:HarmonyHub/models/calendar_event.dart';
import 'package:HarmonyHub/models/forum_details.dart';
import 'package:HarmonyHub/models/project_details.dart';
import 'package:HarmonyHub/models/social_media_links.dart';
import 'package:HarmonyHub/models/video_sources.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'networking.dart';

class Global {
  static double numberToDivide = 1000000000000000000.0;
  static double numberOfSecondsForEpoch = 7.5;
  static int dataRefreshInSeconds = 60;
  static Map<String, String> validatorNames = new Map<String, String>();
  static String selectedNetworkUrl = "https://api.s0.t.hmny.io/";
  static String analyticsDataUrl = "https://staking-explorer2-268108.appspot.com/networks/harmony/staking_network_info";
  static String forumUrl = "https://talk.harmony.one";
  static String docsUrl = "https://docs.harmony.one/";
  static String harmonyOneUrl = "https://harmony.one";
  static String harmonyYoutubeAppLink = "youtube://www.youtube.com/channel/UCDfuhS7xu69IhK5AJSyiF0g";
  static String harmonyYoutubeWebLink = "https://www.youtube.com/channel/UCDfuhS7xu69IhK5AJSyiF0g";
  static String harmonyTelegramLink = "https://t.me/harmony_one";
  static String harmonyDiscordLink = "https://harmony.one/discord";
  static String harmonyRedditLink = "https://harmony.one/reddit";
  static String harmonyGithubLink = "https://harmony.one/github";
  static String hcnTelegramLink =
      "https://staking.harmony.one/validators/mainnet/one1leh5rmuclw5u68gw07d86kqxjd69zuny3h23c3"; //"https://t.me/HarmonyCommunityNode";
  static String harmonyValidatorsWebLink = "https://www.harmonyvalidators.com";
  static String prarySoftLink = "https://prarysoft.com/index.html";
  static String ogreAbroadMediumLink = "https://medium.com/@ogreabroad";
  static String twitterAccountsFilter = "from:@harmonyprotocol OR from:@nickwh8te OR from:@GIZEMCAKIL OR from:@prarysoft OR from:@ogreAbroad";
  static String twitterTweetQuery = "harmony \$ONE OR #ONE";
  static String harmonyYoutubeChannelId = "UCDfuhS7xu69IhK5AJSyiF0g";
  static String oneValAddressKey = 'MYONEVALADDRESS';
  static String oneDelAddressKey = 'MYONEVALADDRESS';
  static String favoriteValListKey = 'FAVORITEVALIDATORLIST';
  static String favoriteDelListKey = 'FAVORITEDELEGATORLIST';
  static String favoriteTwitterHandlesKey = 'TWITTER_HANDLES_KEY';
  static String calenderEventPushNotifications = "calenderEventPushNotifications";

  static String myValONEAddress = '';
  static String myDelONEAddress = '';

  static bool isDarkModeEnabled = false;

  static List<String> allTwitterHandles = new List<String>();
  static List<CalendarEvent> events = new List<CalendarEvent>();
  static List<SocialMediaLinks> smLinks = new List<SocialMediaLinks>();
  static List<VideoSource> videoSources = new List<VideoSource>();
  static List<ForumDetails> forumDetails = new List<ForumDetails>();
  static List<ProjectDetails> projectDetails = new List<ProjectDetails>();

  static String projectIdKey = 'PROJECT_ID';

  static Future<String> getProjectId() async {
    String projectId = await Global.getUserPreferences(projectIdKey);
    if (projectId == null || projectId == '') {
      projectId = "ONE";
    }
    return projectId;
  }

  static Future<String> getMyValONEAddress() async {
    if (Global.myValONEAddress == '') {
      Global.myValONEAddress = await Global.getUserPreferences(Global.oneValAddressKey);
    }
    return Global.myValONEAddress;
  }

  static Future<String> getMyDelONEAddress() async {
    if (Global.myDelONEAddress == '') {
      Global.myDelONEAddress = await Global.getUserPreferences(Global.oneDelAddressKey);
    }
    return Global.myDelONEAddress;
  }

  static Future<String> getUserPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key) ?? '';
  }

  static void setUserPreferences(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    if (key != null && value != null) {
      prefs.setString(key, value);
    }
  }

  static Future<List<String>> getUserFavList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? new List<String>();
  }

  static void setUserFavList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    if (key != null && value != null) {
      prefs.setStringList(key, value);
    }
  }

  static Future<void> getInitializer() async {
    FirebaseFirestore.instance.doc('initializers/IFmVhDydREL0IjMUnUMa').get().then((doc) {
      forumUrl = doc['forum_url'];
      docsUrl = doc['docs_url'];
      if (doc['twitter_tweet_query'] != "") {
        twitterTweetQuery = doc['twitter_tweet_query'];
      }
    });
  }

  static Future<void> getTwitterAccounts() async {
    String projectId = await Global.getProjectId();
    FirebaseFirestore.instance.collection('twitter_accounts').where('project_id', isEqualTo: projectId).get().then((value) {
      allTwitterHandles.clear();
      value.docs.forEach((element) {
        allTwitterHandles.add(element["handle"]);
      });
    });
  }

  static Future<void> getAllValidatorNames() async {
    NetworkHelper networkHelper = NetworkHelper();
    int i = 0;
    int allValCount;
    if (validatorNames == null) {
      validatorNames = new Map<String, String>();
    } else {
      validatorNames.clear();
    }
    while (true) {
      var blockData = await networkHelper.getData(kApiMethodGetAllValidatorInformation, i);
      if (blockData != null) {
        allValCount = (blockData['result']).length;
        if (allValCount == 0) {
          break;
        }
        for (int i = 0; i < allValCount; i++) {
          String address = blockData['result'][i]['validator']['address'];
          String name = blockData['result'][i]['validator']['name'];
          validatorNames[address] = name;
        }
        i++;
      } else {
        break;
      }
    }
    //print(blockData);
  }

  static void checkIfDarkModeEnabled(dynamic context) {
    final ThemeData theme = Theme.of(context);
    theme.brightness == Brightness.dark ? Global.isDarkModeEnabled = true : Global.isDarkModeEnabled = false;
  }

  static Future<dynamic> getMediumArticles() async {}

  static DateTime getNearest15MinuteMark(DateTime moment) {
    if (moment.minute >= 0 && moment.minute < 8) {
      moment = moment.add(Duration(minutes: -moment.minute));
    } else if (moment.minute >= 8 && moment.minute < 16) {
      moment = moment.add(Duration(minutes: 15 - moment.minute));
    } else if (moment.minute >= 16 && moment.minute < 24) {
      moment = moment.add(Duration(minutes: -(moment.minute - 15)));
    } else if (moment.minute >= 24 && moment.minute < 31) {
      moment = moment.add(Duration(minutes: 30 - moment.minute));
    } else if (moment.minute >= 31 && moment.minute < 39) {
      moment = moment.add(Duration(minutes: -(moment.minute - 30)));
    } else if (moment.minute >= 39 && moment.minute < 46) {
      moment = moment.add(Duration(minutes: 45 - moment.minute));
    } else if (moment.minute >= 46 && moment.minute < 54) {
      moment = moment.add(Duration(minutes: -(moment.minute - 45)));
    } else if (moment.minute >= 54 && moment.minute <= 59) {
      moment = moment.add(Duration(minutes: 60 - moment.minute));
    }
    print(moment);

    return moment;
  }

  static Color getColorFromString(String strColor) {
    if (strColor == "" || strColor == null) {
      return Colors.transparent;
    }
    Color c = Colors.transparent;
    if (strColor == "blue") {
      c = Colors.blue;
    } else if (strColor == "green") {
      c = Colors.green;
    } else if (strColor == "red") {
      c = Colors.red;
    } else if (strColor == "yellow") {
      c = Colors.yellow;
    } else if (strColor == "teal") {
      c = Colors.teal;
    } else if (strColor == "brown") {
      c = Colors.brown;
    } else if (strColor == "black") {
      c = Colors.black;
    } else if (strColor == "orange") {
      c = Colors.orange;
    } else if (strColor == "purple") {
      c = Colors.purple;
    }
    return c;
  }

  static IconData getIconForString(String strIcon) {
    if (strIcon == "browser" || strIcon == "firefoxBrowser") {
      return FontAwesomeIcons.firefoxBrowser;
    } else if (strIcon == "bookReader") {
      return FontAwesomeIcons.bookReader;
    } else if (strIcon == "building") {
      return FontAwesomeIcons.building;
    } else if (strIcon == "youtube") {
      return FontAwesomeIcons.youtube;
    } else if (strIcon == "discord") {
      return FontAwesomeIcons.discord;
    } else if (strIcon == "reddit") {
      return FontAwesomeIcons.reddit;
    } else if (strIcon == "github") {
      return FontAwesomeIcons.github;
    } else if (strIcon == "telegram") {
      return FontAwesomeIcons.telegram;
    } else if (strIcon == "bookReader") {
      return FontAwesomeIcons.bookReader;
    } else {
      return FontAwesomeIcons.question;
    }
  }
}
