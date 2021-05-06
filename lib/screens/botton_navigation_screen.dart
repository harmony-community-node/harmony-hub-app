import 'dart:io';

import 'package:HarmonyHub/models/forum_details.dart';
import 'package:HarmonyHub/screens/calendar_screen.dart';
import 'package:HarmonyHub/screens/socialmedia_links_screen.dart';
import 'package:HarmonyHub/screens/videos_feed_screen.dart';
import 'package:HarmonyHub/services/forum_service.dart';
import 'package:HarmonyHub/services/notification_handler.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/constants.dart';
import 'info_screen.dart';
import 'medium_feed_screen.dart';
import 'twitter_feed_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  PageController _c;
  int _page = 0;
  final HarmonyHubNotificationHandler notificationHandler = HarmonyHubNotificationHandler();
  List<Widget> screens = new List<Widget>();
  final PageStorageBucket bucket = PageStorageBucket();
  ForumService forumService = new ForumService();
  CalendarScreen _calendarScreen;
  TwitterFeedScreen _twitterFeedScreen;
  MediumFeedScreen _mediumFeedScreen;
  VideosFeedScreen _videosFeedScreen;
  InformationScreen _forumScreen;

  @override
  void initState() {
    //Global.getInitializer();
    super.initState();
    _c = new PageController(
      initialPage: _page,
    );
    notificationHandler.initNotifications(context);
    setupScreens();
  }

  void setupScreens() async {
    List<ForumDetails> forumDetails = await forumService.getForumDetails();
    if (forumDetails.length > 0) {
      _forumScreen = new InformationScreen(
        url: forumDetails[0].url,
        title: forumDetails[0].title,
        showAppIcon: true,
      );
    }
    _calendarScreen = new CalendarScreen();
    _twitterFeedScreen = new TwitterFeedScreen(key: TwitterFeedScreen.twitterFeedScreenKey);
    _mediumFeedScreen = new MediumFeedScreen(key: MediumFeedScreen.articleFeedScreenKey);
    _videosFeedScreen = new VideosFeedScreen(key: VideosFeedScreen.videoFeedScreenKey);
    setState(() {
      screens.clear();
    });
    List<Widget> srs = [];
    srs.add(_calendarScreen);
    srs.add(_twitterFeedScreen);
    srs.add(_mediumFeedScreen);
    srs.add(new VideosFeedScreen());
    if (_forumScreen != null) {
      srs.add(_forumScreen);
    }
    srs.add(new SocialMediaScreen(
      refreshBottomNavigation: refreshScreens,
    ));
    setState(() {
      screens = srs;
    });
  }

  void refreshScreens() async {
    List<ForumDetails> forumDetails = await forumService.getForumDetails();
    if (forumDetails.length > 0) {
      _forumScreen = new InformationScreen(
        url: forumDetails[0].url,
        title: forumDetails[0].title,
        showAppIcon: true,
      );
    }
    if (_forumScreen != null) {
      screens[4] = _forumScreen;
    }
    try {
      _twitterFeedScreen.refreshTweets();
    } catch (Exception) {}
    try {
      _videosFeedScreen.refreshVideos();
    } catch (Exception) {}
    try {
      _mediumFeedScreen.refreshArticles();
    } catch (Exception) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new PageView(
        controller: _c,
        onPageChanged: (newPage) {
          setState(() {
            this._page = newPage;
          });
        },
        children: Platform.isIOS ? screens : screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 18,
        items: Platform.isIOS
            ? const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.calendar),
                  label: 'Calendar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.hashtag),
                  label: 'Social',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.mediumM),
                  label: 'Articles',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.video),
                  label: 'Videos',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.commentDots),
                  label: 'Forum',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.info),
                  label: 'Info',
                ),
              ]
            : const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.calendar),
                  label: 'Calendar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.hashtag),
                  label: 'Social',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.mediumM),
                  label: 'Articles',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.video),
                  label: 'Videos',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.commentDots),
                  label: 'Forum',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.info),
                  label: 'Info',
                ),
              ],
        currentIndex: _page,
        onTap: (index) {
          _page = index;
          this._c.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
        },
        selectedItemColor: kHmyMainColor,
        unselectedItemColor: kHmyGreyCardColor,
        backgroundColor: kHmyGreyCardColor,
        selectedLabelStyle: GoogleFonts.nunito(
          fontStyle: FontStyle.normal,
          color: kHmyMainColor,
        ),
        unselectedLabelStyle: GoogleFonts.nunito(
          fontStyle: FontStyle.normal,
          color: kHmyNormalTextColor,
        ),
      ),
    );
  }
}
