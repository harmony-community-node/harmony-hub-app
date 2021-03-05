import 'package:HarmonyHub/models/social_media_links.dart';
import 'package:HarmonyHub/services/firebase_auth.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SocialMediaLinksService {
  final String smLinksTable = "social_media_links";
  Future<List<SocialMediaLinks>> getSocialMediaLinks() async {
    await Firebase.initializeApp();
    FirebaseAuthService fas = new FirebaseAuthService();
    String userId = await fas.getUserId();
    String projectId = await Global.getProjectId();
    if (userId != null) {
      QuerySnapshot smLinks = await FirebaseFirestore.instance
          .collection(smLinksTable)
          .where(
            'project_id',
            isEqualTo: projectId,
          )
          .get();
      Global.smLinks.clear();
      List<String> docIds = new List<String>();
      for (int i = 0; i < smLinks.docs.length; i++) {
        var element = smLinks.docs[i];
        docIds.add(element.id);
        SocialMediaLinks smLink = SocialMediaLinks(
          index: element['index'],
          title: element['title'],
          url: element['url'],
          projectId: element['project_id'],
          icon: element['icon'],
          linkType: element['link_type'],
        );
        Global.smLinks.add(smLink);
      }
    }
    if (Global.smLinks.length > 1) {
      Global.smLinks.sort((a, b) => a.index.compareTo(b.index));
    }
    return Global.smLinks;
  }
}
