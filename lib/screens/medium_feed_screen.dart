import 'dart:convert';

import 'package:HarmonyHub/models/article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:xml2json/xml2json.dart';
import 'package:xml_parser/xml_parser.dart';

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
  List<String> accounts = new List<String>();

  @override
  void initState() {
    super.initState();
    getAccounts();
  }

  Future<void> getAccounts() async {
    Firestore.instance.collection('medium_accounts').getDocuments().then((value) {
      value.documents.forEach((element) {
        accounts.add(element['handle']);
      });
      getArticles();
    });
  }

  Future<void> getArticles() async {
    setState(() {
      dataLoading = true;
    });
    List<Article> articles = new List<Article>();
    // Parse this package's pub.dev page as a XML document.

    for (int a = 0; a < accounts.length; a++) {
      String account = accounts[a];
      try {
        XmlDocument xmlDocument = await XmlDocument.fromUri("https://medium.com/feed/@$account");
        for (XmlNode child in xmlDocument.children) {
          if (child is XmlElement) {
            print(child.name);
            if (child.name == "rss") {
              final xmlToJson = Xml2Json();
              xmlToJson.parse(child.toString());
              var feed = json.decode(xmlToJson.toBadgerfish());
              List<dynamic> itemsList = feed["rss"]["channel"]["item"];
              if (itemsList.length > 0) {
                int i = 0;
                for (dynamic item in itemsList) {
                  //print("${item['title']} - ${item['atom:updated']["\$"]}");
                  //print(item["content:encoded"]["__cdata"]);
                  String content = item["content:encoded"]["__cdata"];
                  String itemTitle = item['title']["__cdata"];
                  if (content.contains("harmony") || content.contains("harmony one") || content.contains("ONE")) {
                    String articleURL = item['link']["\$"];
                    String updatedDate = item['atom:updated']["\$"];

                    String imgUrl = "";
                    try {
                      final startIndex = content.indexOf("<figure>");
                      final endIndex = content.indexOf("</figure>", startIndex + "<figure>".length);
                      String imgTag = content.substring(startIndex + "<figure>".length, endIndex);
                      final srcStartIndex = imgTag.indexOf("src=\"");
                      final srcEndIndex = imgTag.indexOf("\"", srcStartIndex + "src=\"".length);
                      imgUrl = imgTag.substring(srcStartIndex + "src=\"".length, srcEndIndex);
                    } catch (e) {}
                    Article article = new Article(
                        order: 1,
                        title: itemTitle,
                        description: "\nPublished By : $account \n\nPublish On : ${item['pubDate']["\$"]}",
                        imageUrl: imgUrl,
                        articleUrl: articleURL,
                        articleDate: DateTime.parse(updatedDate));

                    i++;
                    articles.add(article);
                  }
                }
              }
              print(articles.length);
            }
          }
        }
      } catch (e) {}
    }
    articles.sort((a, b) => b.articleDate.compareTo(a.articleDate));
    refreshData(articles);
  }

  Future<void> refreshData(List<Article> articles) async {
    List<Widget> articleWidgets = new List<Widget>();
    int numberOfArticles = articles.length > 150 ? 150 : articles.length;
    for (int i = 0; i < numberOfArticles; i++) {
      Article art = articles[i];
      ListViewItem item = ListViewItem(
        height: 100,
        title: art.title,
        text: art.description,
        leading: art.imageUrl == ""
            ? Image.asset(
                "assets/medium.png",
                height: 80.0,
                width: 50.0,
              )
            : Image.network(
                art.imageUrl,
                height: 80.0,
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
      dataLoading = false;
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
      body: dataLoading
          ? SpinKitDoubleBounce(
              color: Colors.grey,
              size: 50.0,
            )
          : Container(
              child: RefreshIndicator(
                onRefresh: getAccounts,
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
