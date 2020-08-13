import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/constants.dart';
import '../utilities/globals.dart';

class VideoListViewItem extends StatelessWidget {
  VideoListViewItem({@required this.title, @required this.text, this.moreDetails, this.openMoreDetails, this.selectable, this.height, this.leading});
  final String title;
  final String text;
  final bool moreDetails;
  final Function openMoreDetails;
  final bool selectable;
  final double height;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    bool showArrow = false;
    if (moreDetails != null) {
      showArrow = moreDetails;
    }
    return Container(
      height: height != null ? height : 80.0,
      child: ListTile(
        leading: leading,
        title: Text(
          '$title',
          style: GoogleFonts.nunito(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          textAlign: TextAlign.left,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          text,
          style: GoogleFonts.nunito(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: kHmyNormalTextColor,
          ),
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          maxLines: 6,
        ),
        trailing: showArrow ? Icon(FontAwesomeIcons.chevronRight) : null,
        enabled: true,
        onTap: openMoreDetails,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Global.isDarkModeEnabled ? Colors.black : Colors.white,
      ),
    );
  }
}
