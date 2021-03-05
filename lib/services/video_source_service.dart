import 'package:HarmonyHub/models/video_sources.dart';
import 'package:HarmonyHub/services/firebase_auth.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class VideoSourceService {
  final String videoSourcesTable = "video_sources";
  Future<List<VideoSource>> getVideoSources() async {
    await Firebase.initializeApp();
    FirebaseAuthService fas = new FirebaseAuthService();
    String userId = await fas.getUserId();
    String projectId = await Global.getProjectId();
    if (userId != null) {
      QuerySnapshot videoSources = await FirebaseFirestore.instance
          .collection(videoSourcesTable)
          .where(
            'project_id',
            isEqualTo: projectId,
          )
          .get();
      Global.videoSources.clear();
      List<String> docIds = new List<String>();
      for (int i = 0; i < videoSources.docs.length; i++) {
        var element = videoSources.docs[i];
        docIds.add(element.id);
        VideoSource vSource = VideoSource(
          channelId: element['channel_id'],
          source: element['source'],
          url: element['url'],
          projectId: element['project_id'],
        );
        Global.videoSources.add(vSource);
      }
    }
    return Global.videoSources;
  }
}
