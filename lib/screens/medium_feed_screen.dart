import 'package:HarmonyHub/components/list_view_item.dart';
import 'package:HarmonyHub/models/article_source.dart';
import 'package:HarmonyHub/screens/article_filter_screen.dart';
import 'package:HarmonyHub/screens/info_screen.dart';
import 'package:HarmonyHub/services/article_source_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../components/resuable_card.dart';
import '../utilities/constants.dart';
import '../utilities/globals.dart';

class MediumFeedScreen extends StatefulWidget {
  MediumFeedScreen({Key key}) : super(key: key);
  @override
  _MediumFeedScreenState createState() => _MediumFeedScreenState();
  static final GlobalKey<_MediumFeedScreenState> articleFeedScreenKey = GlobalKey<_MediumFeedScreenState>();
  void refreshArticles() {
    articleFeedScreenKey.currentState.getArticles();
  }
}

class _MediumFeedScreenState extends State<MediumFeedScreen> {
  bool dataLoading = false;
  List<Widget> articleItems = [];
  List<String> accounts = [];
  ArticleSourceService articleSourceService = new ArticleSourceService();

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  Future<void> getArticles() async {
    setState(() {
      dataLoading = true;
    });
    List<Widget> articleWidgets = [];
    List<ArticleSource> articles = await articleSourceService.getArticleSources();
    articles.sort((a, b) => b.publishedDate.compareTo(a.publishedDate));
    int numberOfArticles = articles.length > 150 ? 150 : articles.length;
    for (int i = 0; i < numberOfArticles; i++) {
      ArticleSource art = articles[i];
      ListViewItem item = ListViewItem(
        height: 100,
        title: art.title,
        text: "\nPublished By : ${art.provider}\n\nPublished Date : ${DateFormat('dd-MMM-yyyy HH:mm').format(art.publishedDate)}",
        leading: art.thumbnailUrl == ""
            ? Image.asset(
                "assets/medium.png",
                height: 80.0,
                width: 50.0,
              )
            : Image.network(
                art.thumbnailUrl,
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
                url: art.url,
              ),
            ),
          );
        },
      );
      articleWidgets.add(item);
      SizedBox sb = SizedBox(height: 1);
      articleWidgets.add(sb);
    }
    if (mounted) {
      setState(() {
        articleItems.clear();
        articleItems = articleWidgets;
        dataLoading = false;
      });
    }
  }

  /*Future<void> getAccounts() async {
    accounts.clear();
    String projectId = await Global.getProjectId();
    FirebaseFirestore.instance.collection('medium_accounts').where('project_id', isEqualTo: projectId).get().then((value) {
      value.docs.forEach((element) {
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
                    var pubDate;
                    String imgUrl = "";
                    try {
                      final startIndex = content.indexOf("<figure>");
                      final endIndex = content.indexOf("</figure>", startIndex + "<figure>".length);
                      String imgTag = content.substring(startIndex + "<figure>".length, endIndex);
                      final srcStartIndex = imgTag.indexOf("src=\"");
                      final srcEndIndex = imgTag.indexOf("\"", srcStartIndex + "src=\"".length);
                      imgUrl = imgTag.substring(srcStartIndex + "src=\"".length, srcEndIndex);
                      DateFormat dateFormat = new DateFormat("E, d MMM y H:m:s");
                      pubDate = dateFormat.parse(item['pubDate']["\$"]);
                    } catch (e) {
                      print(e);
                    }
                    Article article = new Article(
                        order: 1,
                        title: itemTitle,
                        description: "\nPublished By : $account \n\nPublish On : ${new DateFormat.yMMMd().format(pubDate)}",
                        imageUrl: imgUrl,
                        articleUrl: articleURL,
                        publishedDate: pubDate != null ? pubDate : DateTime.parse(updatedDate),
                        updatedDate: DateTime.parse(updatedDate));

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
    articles.sort((a, b) => b.publishedDate.compareTo(a.publishedDate));
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
    if (mounted) {
      setState(() {
        articleItems.clear();
        articleItems = articleWidgets;
        dataLoading = false;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    Global.checkIfDarkModeEnabled(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Image.asset(
            'assets/app_icon.png',
          ),
        ),
        actions: [
          new IconButton(
            icon: Icon(FontAwesomeIcons.filter),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleFilterScreen(
                    refreshArticles: getArticles,
                  ),
                ),
              );
            },
          ),
        ],
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
