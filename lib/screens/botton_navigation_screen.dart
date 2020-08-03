import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/constants.dart';
import '../utilities/globals.dart';
import 'info_screen.dart';
import 'medium_feed_screen.dart';
import 'social_feed_screen.dart';
import 'twitter_feed_screen.dart';
import 'videos_feed_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;
  Widget bodyWidget = InformationScreen(
    url: Global.forumUrl,
    title: 'Discuss',
  );
  final List<Widget> _children = [
    InformationScreen(
      url: Global.forumUrl,
      title: 'Discuss',
    ),
    SocialFeedScreen(),
    MediumFeedScreen(),
    VideosFeedScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      bodyWidget = null;
      switch (_selectedIndex) {
        case 0:
          bodyWidget = InformationScreen(
            url: Global.forumUrl,
            title: 'Discuss',
          );
          break;
        case 1:
          bodyWidget = TwitterFeedScreen();
          break;
        case 2:
          bodyWidget = MediumFeedScreen();
          break;
        case 3:
          bodyWidget = VideosFeedScreen();
          break;
        default:
          bodyWidget = InformationScreen(
            url: Global.forumUrl,
            title: 'Discuss',
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.commentDots),
            title: Text('Forum'),
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
            icon: Icon(FontAwesomeIcons.youtube),
            title: Text('Youtube'),
          ),
        ],
        currentIndex: _selectedIndex,
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
        onTap: _onItemTapped,
      ),
    );
  }
}
