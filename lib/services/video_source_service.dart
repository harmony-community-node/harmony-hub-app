import 'package:HarmonyHub/models/video_sources.dart';
import 'package:HarmonyHub/services/firebase_auth.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class VideoSourceService {
  final String videoSourcesTable = "videos_metadata";
  Future<List<VideoSource>> getVideoSources() async {
    await Firebase.initializeApp();
    FirebaseAuthService fas = new FirebaseAuthService();
    String userId = await fas.getUserId();
    String projectId = await Global.getProjectId();
    if (userId != null) {
      List<String> filters = await Global.getUserFavList(Global.favoriteVideoHandlesKey);
      bool includeSearchItems = false;
      List<String> selectedProviders = [];
      for (String filter in filters) {
        List<String> parts = filter.split(":##:");
        if (parts.length > 1) {
          if (parts[1] == 'search') {
            includeSearchItems = true;
          }
        }
        if (parts.length > 2) {
          selectedProviders.add(parts[2]);
        }
      }
      Global.videoSources.clear();
      QuerySnapshot videoSources = await FirebaseFirestore.instance
          .collection(videoSourcesTable)
          .where(
            'project_id',
            isEqualTo: projectId,
          )
          .get();
      List<String> docIds = [];
      for (int i = 0; i < videoSources.docs.length; i++) {
        var element = videoSources.docs[i];
        String provider = element['video_provider'];
        if (selectedProviders.contains(provider) || includeSearchItems) {
          docIds.add(element.id);
          VideoSource vSource = VideoSource(
            docId: element.id,
            title: element['title'],
            description: element['description'],
            videoDatetime: element['video_datetime'].toDate(),
            projectId: element['project_id'],
            videoProvider: element['video_provider'],
            videoSource: element['video_source'],
            videoUrl: element['video_url'],
            thumbnailURL: element['video_thumbnail_url'],
          );
          Global.videoSources.add(vSource);
        }
      }
      return Global.videoSources;
    }
    return Global.videoSources;
  }
}
