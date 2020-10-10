import 'dart:io';

import 'package:HarmonyHub/screens/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/resuable_card.dart';
import '../utilities/constants.dart';
import '../utilities/globals.dart';
import 'info_screen.dart';

class SocialMediaScreen extends StatefulWidget {
  @override
  _SocialMediaScreenState createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  List<dynamic> socialItems = new List<dynamic>();
  int itemsCount = 0;

  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Information  '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: GoogleFonts.nunito(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: kHmyMainColor,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OK',
                style: GoogleFonts.nunito(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: kHmyMainColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void openYoutube() async {
    if (Platform.isIOS) {
      if (await canLaunch(Global.harmonyYoutubeAppLink)) {
        await launch(Global.harmonyYoutubeAppLink, forceSafariVC: false);
      } else {
        if (await canLaunch(Global.harmonyYoutubeWebLink)) {
          print('Here');
          await launch(Global.harmonyYoutubeWebLink);
        } else {
          _showMyDialog('Something went wrong, please try again later.');
        }
      }
    } else {
      if (await canLaunch(Global.harmonyYoutubeWebLink)) {
        await launch(Global.harmonyYoutubeWebLink);
      } else {
        _showMyDialog('Something went wrong, please try again later.');
      }
    }
  }

  void gotoHarmonyScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InformationScreen(
          url: Global.harmonyOneUrl,
          title: 'Harmony.one',
        ),
      ),
    );
  }

  void gotoHarmonyDocumentation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InformationScreen(
          url: Global.docsUrl,
          title: 'Documentation',
        ),
      ),
    );
  }

  void openTelegram() async {
    if (await canLaunch(Global.harmonyTelegramLink)) {
      launch(Global.harmonyTelegramLink);
    } else {
      _showMyDialog('Something went wrong, please try again later.');
    }
  }

  void openPrarySoft() async {
    if (await canLaunch(Global.prarySoftLink)) {
      await launch(Global.prarySoftLink);
    } else {
      _showMyDialog('Something went wrong, please try again later.');
    }
  }

  void openDiscord() async {
    if (await canLaunch(Global.harmonyDiscordLink)) {
      await launch(Global.harmonyDiscordLink);
    } else {
      _showMyDialog('Something went wrong, please try again later.');
    }
  }

  void openReddit() async {
    if (await canLaunch(Global.harmonyRedditLink)) {
      await launch(Global.harmonyRedditLink);
    } else {
      _showMyDialog('Something went wrong, please try again later.');
    }
  }

  void openGithub() async {
    if (await canLaunch(Global.harmonyGithubLink)) {
      await launch(Global.harmonyGithubLink);
    } else {
      _showMyDialog('Something went wrong, please try again later.');
    }
  }

  void openHCNTelegram() async {
    if (await canLaunch(Global.hcnTelegramLink)) {
      await launch(Global.hcnTelegramLink);
    } else {
      _showMyDialog('Something went wrong, please try again later.');
    }
  }

  void refreshData() {
    List<dynamic> setItems = new List<dynamic>();
    setItems.add(
      {
        'title': 'Harmony.one',
        'icon': FontAwesomeIcons.firefoxBrowser,
        'event': gotoHarmonyScreen,
      },
    );
    setItems.add(
      {
        'title': 'Documention',
        'icon': FontAwesomeIcons.bookReader,
        'event': gotoHarmonyDocumentation,
      },
    );
    setItems.add(
      {
        'title': 'Harmony Youtube Channel',
        'icon': FontAwesomeIcons.youtube,
        'event': openYoutube,
      },
    );
    setItems.add(
      {
        'title': 'Discord',
        'icon': FontAwesomeIcons.discord,
        'event': openDiscord,
      },
    );
    setItems.add(
      {
        'title': 'Reddit',
        'icon': FontAwesomeIcons.reddit,
        'event': openReddit,
      },
    );
    setItems.add(
      {
        'title': 'Github',
        'icon': FontAwesomeIcons.github,
        'event': openGithub,
      },
    );
    setItems.add(
      {
        'title': 'Telegram',
        'icon': FontAwesomeIcons.telegram,
        'event': openTelegram,
      },
    );
    setItems.add(
      {
        'title': 'Harmony Community Node',
        'icon': FontAwesomeIcons.telegram,
        'event': openHCNTelegram,
      },
    );

    setState(() {
      socialItems = setItems;
      itemsCount = socialItems.length;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    Global.checkIfDarkModeEnabled(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Image.asset(
            'assets/app_icon.png',
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: itemsCount,
              itemBuilder: (BuildContext context, int index) {
                var item = socialItems[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  child: ReusableCard(
                    cardChild: ListTile(
                      trailing: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: kHmyMainColor,
                        size: 20.0,
                      ),
                      leading: Icon(
                        item['icon'],
                        color: kHmyMainColor,
                        size: 20.0,
                      ),
                      title: Text(
                        item['title'],
                        style: GoogleFonts.nunito(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      onTap: item['event'],
                    ),
                    colour: Global.isDarkModeEnabled ? Colors.black : Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
