import 'package:HarmonyHub/models/project_details.dart';
import 'package:HarmonyHub/services/firebase_auth.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ProjectDetailsService {
  final String projectDetailsTable = "projects";
  Future<List<ProjectDetails>> getProjectDetails() async {
    await Firebase.initializeApp();
    FirebaseAuthService fas = new FirebaseAuthService();
    String userId = await fas.getUserId();
    String projectId = await Global.getProjectId();
    if (userId != null) {
      QuerySnapshot projectDetails = await FirebaseFirestore.instance.collection(projectDetailsTable).get();
      Global.projectDetails.clear();
      List<String> docIds = new List<String>();
      for (int i = 0; i < projectDetails.docs.length; i++) {
        var element = projectDetails.docs[i];
        docIds.add(element.id);
        ProjectDetails projectDetail = ProjectDetails(
          title: element['title'],
          projectId: element['project_id'],
        );
        Global.projectDetails.add(projectDetail);
      }
    }
    return Global.projectDetails;
  }
}
