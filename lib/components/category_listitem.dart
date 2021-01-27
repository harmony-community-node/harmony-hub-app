import 'package:HarmonyHub/utilities/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryListItem extends StatelessWidget {
  CategoryListItem({@required this.title, @required this.color, this.colorString});
  final Color color;
  final String title;
  final String colorString;

  @override
  Widget build(BuildContext context) {
    Global.checkIfDarkModeEnabled(context);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            color: color,
            width: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: GoogleFonts.nunito(
              fontSize: 12,
              fontStyle: FontStyle.normal,
              letterSpacing: 1,
              color: Global.isDarkModeEnabled ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Global.isDarkModeEnabled ? Colors.black : Colors.white,
      ),
    );
  }
}
