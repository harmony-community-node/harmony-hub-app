import 'dart:io';

import 'package:HarmonyHub/screens/calendar_screen.dart';
import 'package:HarmonyHub/screens/socialmedia_links_screen.dart';
import 'package:HarmonyHub/screens/videos_feed_screen.dart';
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

  InformationScreen forumScreen = new InformationScreen(
    url: Global.forumUrl,
    title: 'Forum',
    showAppIcon: true,
  );

  @override
  void initState() {
    super.initState();
    Global.getInitializer();
    _c = new PageController(
      initialPage: _page,
    );
    notificationHandler.initNotifications(context);
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
        children: Platform.isIOS
            ? <Widget>[
                new CalendarScreen(),
                new TwitterFeedScreen(),
                new MediumFeedScreen(),
                new VideosFeedScreen(),
                forumScreen,
                SocialMediaScreen(),
              ]
            : <Widget>[
                new CalendarScreen(),
                new TwitterFeedScreen(),
                new MediumFeedScreen(),
                forumScreen,
                SocialMediaScreen(),
              ],
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
                  icon: Icon(FontAwesomeIcons.youtube),
                  label: 'Youtube',
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
                  title: Text('Calendar'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.hashtag),
                  title: Text('Social'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.mediumM),
                  title: Text('Articles'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.commentDots),
                  title: Text('Forum'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.info),
                  title: Text('Info'),
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
