import 'package:HarmonyHub/models/article_source.dart';
import 'package:HarmonyHub/services/firebase_auth.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ArticleSourceService {
  final String articleSourcesTable = "articles_metadata";
  Future<List<ArticleSource>> getArticleSources() async {
    await Firebase.initializeApp();
    FirebaseAuthService fas = new FirebaseAuthService();
    String userId = await fas.getUserId();
    String projectId = await Global.getProjectId();
    List<String> filters = await Global.getUserFavList(Global.favoriteArticleHandlesKey);
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
    if (userId != null) {
      Global.articleSources.clear();
      QuerySnapshot articleSources = await FirebaseFirestore.instance
          .collection(articleSourcesTable)
          .where(
            'project_id',
            isEqualTo: projectId,
          )
          .get();
      for (int i = 0; i < articleSources.docs.length; i++) {
        try {
          var element = articleSources.docs[i];
          String provider = element['article_provider'];
          if (selectedProviders.contains(provider) || includeSearchItems) {
            ArticleSource aSource = ArticleSource(
              docId: element.id,
              title: element['article_title'],
              description: element['article_description'],
              publishedDate: element['article_datatime'].toDate(),
              updatedDate: element['article_datatime'].toDate(),
              projectId: element['project_id'],
              provider: provider,
              source: element.data()['article_source'],
              url: element['article_url'],
              thumbnailUrl: element['article_thumbnail_url'],
            );
            Global.articleSources.add(aSource);
          }
        } on Exception catch (ex) {}
      }
      return Global.articleSources;
    }
    return Global.articleSources;
  }
}
