import 'package:HarmonyHub/utilities/constants.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleFilterScreen extends StatefulWidget {
  ArticleFilterScreen({this.refreshArticles});
  final Function refreshArticles;
  @override
  _ArticleFilterScreenState createState() => _ArticleFilterScreenState();
}

class _ArticleFilterScreenState extends State<ArticleFilterScreen> {
  List<String> filters = [];
  Function refreshArticles;
  String projectId;
  Future<void> getArticleFilters() async {
    projectId = await Global.getProjectId();
    if (projectId == null || projectId == "") {
      projectId = "ONE";
    }
    filters = await Global.getUserFavList(Global.favoriteArticleHandlesKey);
  }

  @override
  void initState() {
    super.initState();
    refreshArticles = widget.refreshArticles;
    Firebase.initializeApp().whenComplete(() {
      getArticleFilters();
      setState(() {});
    });
  }

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text(
        !(document['handle'].toString().contains("\$") || document['handle'].toString().contains("#"))
            ? "${document['handle']}"
            : "${document['handle']}",
        style: GoogleFonts.nunito(
          fontStyle: FontStyle.normal,
          color: kHmyMainColor,
        ),
      ),
      subtitle: Text(
        document['name'],
        style: GoogleFonts.nunito(
          fontStyle: FontStyle.normal,
          color: kHmyNormalTextColor,
        ),
      ),
      selected: true,
      trailing: filters.contains("${document['handle']}:##:${document['type']}:##:${document['name']}")
          ? Icon(Icons.check_box)
          : Icon(Icons.check_box_outline_blank),
      onTap: () {
        setState(() {
          if (filters.contains("${document['handle']}:##:${document['type']}:##:${document['name']}")) {
            filters.remove("${document['handle']}:##:${document['type']}:##:${document['name']}");
          } else {
            filters.add("${document['handle']}:##:${document['type']}:##:${document['name']}");
          }
        });
        Global.setUserFavList(Global.favoriteArticleHandlesKey, filters);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Global.checkIfDarkModeEnabled(context);
    return WillPopScope(
      onWillPop: () async {
        refreshArticles();
        return true;
      },
      child: new Scaffold(
        appBar: AppBar(
          title: Text('Article Filter'),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('article_filters')
              .where(
                'project_id',
                isEqualTo: projectId,
              )
              .orderBy('order', descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              SpinKitDoubleBounce(
                color: Colors.grey,
                size: 50.0,
              );
            }
            return ListView.builder(
              itemExtent: 60.0,
              itemCount: snapshot.data == null ? 0 : snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return _buildList(context, snapshot.data.docs[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
