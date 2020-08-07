import 'package:HarmonyHub/models/article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    getArticles();
  }

  Future<void> getArticles() async {
    Firestore.instance.collection('medium_articles').getDocuments().then((value) {
      List<Article> articles = new List<Article>();
      value.documents.forEach((element) {
        Article article = new Article(
          order: element["order"],
          title: element["title"],
          description: element["description"],
          imageUrl: element["image_url"],
          articleUrl: element["url"],
        );
        articles.add(article);
      });
      refreshData(articles);
    });
  }

  Future<void> refreshData(List<Article> articles) async {
    List<Widget> articleWidgets = new List<Widget>();
    for (int i = 0; i < articles.length; i++) {
      Article art = articles[i];
      ListViewItem item = ListViewItem(
        height: 160,
        title: art.title,
        text: art.description,
        leading: Image.network(
          art.imageUrl,
          height: 70.0,
          width: 50.0,
        ),
        moreDetails: true,
        openMoreDetails: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InformationScreen(
                title: art.title,
                url: art.articleUrl,
              ),
            ),
          );
        },
      );
      articleWidgets.add(item);
      SizedBox sb = SizedBox(height: 1);
      articleWidgets.add(sb);
    }
    setState(() {
      articleItems = articleWidgets;
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
          onRefresh: getArticles,
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
