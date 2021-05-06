import 'package:HarmonyHub/utilities/constants.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoFilterScreen extends StatefulWidget {
  VideoFilterScreen({this.refreshVideos});
  final Function refreshVideos;
  @override
  _VideoFilterScreenState createState() => _VideoFilterScreenState();
}

class _VideoFilterScreenState extends State<VideoFilterScreen> {
  List<String> filters = [];
  Function refreshVideos;
  String projectId;
  Future<void> getVideoFilters() async {
    projectId = await Global.getProjectId();
    if (projectId == null || projectId == "") {
      projectId = "ONE";
    }
    filters = await Global.getUserFavList(Global.favoriteVideoHandlesKey);
  }

  @override
  void initState() {
    super.initState();
    refreshVideos = widget.refreshVideos;
    Firebase.initializeApp().whenComplete(() {
      getVideoFilters();
      setState(() {});
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
        document['title'],
        style: GoogleFonts.nunito(
          fontStyle: FontStyle.normal,
          color: kHmyNormalTextColor,
        ),
      ),
      selected: true,
      trailing: filters.contains("${document['handle']}:##:${document['type']}:##:${document['channel_id']}")
          ? Icon(Icons.check_box)
          : Icon(Icons.check_box_outline_blank),
      onTap: () {
        setState(() {
          if (filters.contains("${document['handle']}:##:${document['type']}:##:${document['channel_id']}")) {
            filters.remove("${document['handle']}:##:${document['type']}:##:${document['channel_id']}");
          } else {
            filters.add("${document['handle']}:##:${document['type']}:##:${document['channel_id']}");
          }
        });
        Global.setUserFavList(Global.favoriteVideoHandlesKey, filters);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Global.checkIfDarkModeEnabled(context);
    return WillPopScope(
      onWillPop: () async {
        refreshVideos();
        return true;
      },
      child: new Scaffold(
        appBar: AppBar(
          title: Text('Video Filter'),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('video_filters')
              .where(
                'project_id',
                isEqualTo: projectId,
              )
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
