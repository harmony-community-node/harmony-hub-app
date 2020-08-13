import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/constants.dart';
import '../utilities/globals.dart';
import 'info_screen.dart';
import 'medium_feed_screen.dart';
import 'twitter_feed_screen.dart';
import 'videos_feed_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  PageController _c;
  int _page = 0;
  InformationScreen forumScreen = new InformationScreen(
    url: Global.forumUrl,
    title: 'Forum',
  );

  @override
  void initState() {
    super.initState();
    _c = new PageController(
      initialPage: _page,
    );
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
        children: <Widget>[
          forumScreen,
          new TwitterFeedScreen(),
          new MediumFeedScreen(),
          new VideosFeedScreen(),
        ],
      ),
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
