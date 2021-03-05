import 'package:HarmonyHub/models/forum_details.dart';
import 'package:HarmonyHub/services/firebase_auth.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ForumService {
  final String forumSourcesTable = "forum_links";
  Future<List<ForumDetails>> getForumDetails() async {
    await Firebase.initializeApp();
    FirebaseAuthService fas = new FirebaseAuthService();
    String userId = await fas.getUserId();
    String projectId = await Global.getProjectId();
    if (userId != null) {
      QuerySnapshot forumSources = await FirebaseFirestore.instance
          .collection(forumSourcesTable)
          .where(
            'project_id',
            isEqualTo: projectId,
          )
          .get();
      Global.forumDetails.clear();
      List<String> docIds = new List<String>();
      for (int i = 0; i < forumSources.docs.length; i++) {
        var element = forumSources.docs[i];
        docIds.add(element.id);
        ForumDetails forumDetails = ForumDetails(
          title: element['title'],
          url: element['url'],
          projectId: element['project_id'],
        );
        Global.forumDetails.add(forumDetails);
      }
    }
    return Global.forumDetails;
  }
}
