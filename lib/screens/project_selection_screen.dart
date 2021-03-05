import 'package:HarmonyHub/components/resuable_card.dart';
import 'package:HarmonyHub/models/project_details.dart';
import 'package:HarmonyHub/services/project_details_service.dart';
import 'package:HarmonyHub/utilities/constants.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectSelectionScreen extends StatefulWidget {
  @override
  _ProjectSelectionScreenState createState() => _ProjectSelectionScreenState();
}

class _ProjectSelectionScreenState extends State<ProjectSelectionScreen> {
  int itemsCount = 0;
  ProjectDetailsService projectDetailsService = new ProjectDetailsService();
  List<ProjectDetails> _projectDetails = new List<ProjectDetails>();
  String _currentProject = "ONE";

  void refreshData() async {
    String currentProject = await Global.getProjectId();
    List<ProjectDetails> projectDetails = await projectDetailsService.getProjectDetails();
    setState(() {
      _currentProject = currentProject;
      _projectDetails = projectDetails;
      itemsCount = _projectDetails.length;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    Global.checkIfDarkModeEnabled(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Image.asset(
            'assets/app_icon.png',
          ),
        ),
        actions: [
          new IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: itemsCount,
              itemBuilder: (BuildContext context, int index) {
                ProjectDetails item = _projectDetails[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  child: ReusableCard(
                    cardChild: ListTile(
                      trailing: item.projectId == _currentProject
                          ? Icon(
                              FontAwesomeIcons.check,
                              color: kHmyMainColor,
                              size: 20.0,
                            )
                          : null,
                      leading: Icon(
                        FontAwesomeIcons.building,
                        color: kHmyMainColor,
                        size: 20.0,
                      ),
                      title: Text(
                        item.title,
                        style: GoogleFonts.nunito(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      onTap: () async {
                        Global.setUserPreferences(Global.projectIdKey, item.projectId);
                        setState(() {
                          _currentProject = item.projectId;
                        });
                      },
                    ),
                    colour: Global.isDarkModeEnabled ? Colors.black : Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
