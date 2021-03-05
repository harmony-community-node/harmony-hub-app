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
import '../utilities/globals.dart';
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
  ForumService forumService = new ForumService();

  InformationScreen forumScreen = new InformationScreen(
    url: Global.forumUrl,
    title: 'Forum',
    showAppIcon: true,
  );

  @override
  void initState() {
    super.initState();
    //Global.getInitializer();
    _c = new PageController(
      initialPage: _page,
    );
    notificationHandler.initNotifications(context);
    refreshScreens();
  }

  void refreshScreens() async {
    List<ForumDetails> forumDetails = await forumService.getForumDetails();
    if (forumDetails.length > 0) {
      forumScreen = new InformationScreen(
        url: forumDetails[0].url,
        title: forumDetails[0].title,
        showAppIcon: true,
      );
    }
    setState(() {
      screens.clear();
      screens.add(new CalendarScreen());
      screens.add(new TwitterFeedScreen());
      screens.add(new MediumFeedScreen());
      screens.add(new VideosFeedScreen());
      if (forumScreen != null) {
        screens.add(forumScreen);
      }
      screens.add(new SocialMediaScreen(
        refreshBottomNavigation: refreshScreens,
      ));
    });
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
