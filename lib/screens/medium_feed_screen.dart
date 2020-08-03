import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/list_view_item.dart';
import '../components/resuable_card.dart';
import '../utilities/constants.dart';
import '../utilities/globals.dart';
import 'info_screen.dart';

class MediumFeedScreen extends StatefulWidget {
  @override
  _MediumFeedScreenState createState() => _MediumFeedScreenState();
}

class _MediumFeedScreenState extends State<MediumFeedScreen> {
  bool dataLoading = false;
  List<Widget> articleItems = new List<Widget>();

  @override
  void initState() {
    super.initState();

    refreshData();
  }

  Future<void> refreshData() async {
    List<Widget> articles = new List<Widget>();
    for (int i = 0; i < 1; i++) {
      ListViewItem item = ListViewItem(
        height: 120,
        title: "Harmonious News Release",
        text: "Not a week into its second year of life, and already, Harmony is turning heads. At the end of the article",
        leading: Image.network(
          'https://miro.medium.com/max/700/1*W2zRxvJNRBZy-iQYjWW48w.jpeg',
        ),
        moreDetails: true,
        openMoreDetails: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InformationScreen(
                title: "Harmonious News Release",
                url: "https://medium.com/harmonyweeklynews/harmonious-news-release-5b3f6f940eed",
              ),
            ),
          );
        },
      );
      articles.add(item);
      SizedBox sb = SizedBox(height: 1);
      articles.add(sb);
    }
    setState(() {
      articleItems = articles;
    });
  }

  @override
  Widget build(BuildContext context) {
    Global.checkIfDarkModeEnabled(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: refreshData,
          child: ListView(
            padding: const EdgeInsets.all(5),
            children: <Widget>[
              ReusableCard(
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: articleItems,
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
