import 'package:HarmonyHub/utilities/constants.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class TwitterFilterScreen extends StatefulWidget {
  TwitterFilterScreen({this.refreshTweets});
  final Function refreshTweets;
  @override
  _TwitterFilterScreenState createState() => _TwitterFilterScreenState();
}

class _TwitterFilterScreenState extends State<TwitterFilterScreen> {
  List<String> filters = new List<String>();
  Function refreshTweets;
  Future<void> getTwitterFilters() async {
    filters = await Global.getUserFavList(Global.favoriteTwitterHandlesKey);
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
      refreshTweets = widget.refreshTweets;
      getTwitterFilters();
    });
  }

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text(
        !(document['handle'].toString().contains("\$") || document['handle'].toString().contains("#"))
            ? "@${document['handle']}"
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
      trailing: filters.contains(document['handle']) ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
      onTap: () {
        setState(() {
          if (filters.contains(document['handle'])) {
            filters.remove(document['handle']);
          } else {
            filters.add(document['handle']);
          }
        });
        Global.setUserFavList(Global.favoriteTwitterHandlesKey, filters);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Global.checkIfDarkModeEnabled(context);
    return WillPopScope(
      onWillPop: () async {
        refreshTweets();
        return true;
      },
      child: new Scaffold(
        appBar: AppBar(
          title: Text('Filter'),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('twitter_accounts').snapshots(),
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
