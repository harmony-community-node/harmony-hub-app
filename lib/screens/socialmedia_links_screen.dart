import 'package:HarmonyHub/models/social_media_links.dart';
import 'package:HarmonyHub/screens/info_screen.dart';
import 'package:HarmonyHub/screens/project_selection_screen.dart';
import 'package:HarmonyHub/services/social_media_links_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/resuable_card.dart';
import '../utilities/constants.dart';
import '../utilities/globals.dart';
import 'info_screen.dart';

class SocialMediaScreen extends StatefulWidget {
  SocialMediaScreen({this.refreshBottomNavigation});
  final Function refreshBottomNavigation;
  @override
  _SocialMediaScreenState createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  List<dynamic> socialItems = new List<dynamic>();
  List<SocialMediaLinks> smLinks = new List<SocialMediaLinks>();
  SocialMediaLinksService smLinksService = new SocialMediaLinksService();
  int itemsCount = 0;
  Function _refreshBottomNavigation;

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
            TextButton(
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

  void refreshData() async {
    List<SocialMediaLinks> links = await smLinksService.getSocialMediaLinks();
    setState(() {
      smLinks = links;
      itemsCount = smLinks.length;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshBottomNavigation = widget.refreshBottomNavigation;
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
        actions: [
          new IconButton(
            icon: Icon(FontAwesomeIcons.bars),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectSelectionScreen(),
                ),
              ).whenComplete(() {
                refreshData();
                _refreshBottomNavigation();
              });
            },
          ),
        ],
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
                SocialMediaLinks item = smLinks[index];
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
                        Global.getIconForString(item.icon),
                        color: kHmyMainColor,
                        size: 20.0,
                      ),
                      title: Text(
                        item.title,
                        style: GoogleFonts.nunito(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      onTap: () async {
                        if (item.linkType == 'app') {
                          if (await canLaunch(item.url)) {
                            launch(item.url);
                          } else {
                            _showMyDialog('Something went wrong, please try again later.');
                          }
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InformationScreen(
                                url: item.url,
                                title: item.title,
                              ),
                            ),
                          );
                        }
                      },
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
