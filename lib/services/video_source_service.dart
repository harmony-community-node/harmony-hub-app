import 'package:HarmonyHub/models/video_sources.dart';
import 'package:HarmonyHub/services/firebase_auth.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:html_character_entities/html_character_entities.dart';

class VideoSourceService {
  final String videoSourcesTable = "videos_metadata";
  Future<List<VideoSource>> getVideoSources() async {
    await Firebase.initializeApp();
    FirebaseAuthService fas = new FirebaseAuthService();
    String userId = await fas.getUserId();
    String projectId = await Global.getProjectId();
    if (userId != null) {
      List<String> filters = await Global.getUserFavList(Global.favoriteVideoHandlesKey);
      List<String> unSelectedProviders = await getVideoFilters();
      print(filters);
      print(unSelectedProviders);
      bool includeSearchItems = false;
      List<String> selectedProviders = [];
      if (filters.length == 0) {
        includeSearchItems = true;
      } else {
        for (String filter in filters) {
          List<String> parts = filter.split(":##:");
          if (parts.length > 1) {
            if (parts[1] == 'search') {
              includeSearchItems = true;
            }
          }
          if (parts.length > 2) {
            selectedProviders.add(parts[2]);
            if (unSelectedProviders.contains(parts[2])) {
              unSelectedProviders.remove(parts[2]);
            }
          }
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
        docIds.add(element.id);
        VideoSource vSource = VideoSource(
          docId: element.id,
          title: HtmlCharacterEntities.decode(element['title']),
          description: HtmlCharacterEntities.decode(element['description']),
          videoDatetime: element['video_datetime'].toDate(),
          projectId: element['project_id'],
          videoProvider: element['video_provider'],
          videoSource: element['video_source'],
          videoUrl: element['video_url'],
          thumbnailURL: element['video_thumbnail_url'],
        );
        if (includeSearchItems) {
          if (!unSelectedProviders.contains(provider)) {
            Global.videoSources.add(vSource);
          }
        } else {
          if (selectedProviders.contains(provider)) {
            Global.videoSources.add(vSource);
          }
        }
      }
      return Global.videoSources;
    }
    return Global.videoSources;
  }

  Future<List<String>> getVideoFilters() async {
    await Firebase.initializeApp();
    String projectId = await Global.getProjectId();
    QuerySnapshot articleFilters = await FirebaseFirestore.instance
        .collection('video_filters')
        .where(
          'project_id',
          isEqualTo: projectId,
        )
        .get();
    List<String> filters = [];
    for (int i = 0; i < articleFilters.docs.length; i++) {
      try {
        var element = articleFilters.docs[i];
        String provider = element['channel_id'];
        filters.add(provider);
      } on Exception catch (ex) {}
    }
    return filters;
  }
}
