import 'dart:async';

import 'package:HarmonyHub/components/category_listitem.dart';
import 'package:HarmonyHub/models/calendar_event.dart';
import 'package:HarmonyHub/models/category_item.dart';
import 'package:HarmonyHub/services/events_service.dart';
import 'package:HarmonyHub/services/firebase_auth.dart';
import 'package:HarmonyHub/utilities/constants.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EventDetailsScreen extends StatefulWidget {
  EventDetailsScreen({this.calendarEvent, this.newEvent});
  final CalendarEvent calendarEvent;
  final bool newEvent;
  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool _newEvent;
  EventService _eventService;
  CalendarEvent _calendarEvent;
  TextEditingController _txtTitleController;
  TextEditingController _txtNotesController;
  TextEditingController _txtApprovalCode;
  TextEditingController _txtRepeats;
  String _date = "Not set";
  String _startTime = "Not set";
  String _endTime = "Not set";
  String _userId = "";
  int _selectedCategoryIndex = 0;
  List<CategoryItem> _categoryItems;
  int _selectedRecurrenceIndex = 0;
  List<String> _recurrenceItems;
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController _webViewController;
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  @override
  void initState() {
    super.initState();
    _newEvent = widget.newEvent;
    _eventService = EventService();
    getUserId();
    _calendarEvent = widget.calendarEvent;
    _txtTitleController = TextEditingController(text: _calendarEvent.eventTitle);
    _txtNotesController = TextEditingController(text: _calendarEvent.eventNotes);
    _txtApprovalCode = TextEditingController();
    _txtRepeats = TextEditingController(text: "10");
    if (_newEvent) {
      _calendarEvent.from = Global.getNearest15MinuteMark(
        DateTime(
          _calendarEvent.from.year,
          _calendarEvent.from.month,
          _calendarEvent.from.day,
          DateTime.now().hour,
          DateTime.now().minute,
        ),
      );
      _calendarEvent.to = _calendarEvent.from.add(Duration(minutes: 30));
    }
    _date = '${_calendarEvent.from.year} - ${_calendarEvent.from.month} - ${_calendarEvent.from.day}';
    _startTime = '${_calendarEvent.from.hour} - ${_calendarEvent.from.minute.toString().padLeft(2, '0')}';
    _endTime = '${_calendarEvent.to.hour} - ${_calendarEvent.to.minute.toString().padLeft(2, '0')}';
    buildCategoryItemList();
    _recurrenceItems = ["None", "Daily", "Weekly", "Monthly"];
  }

  void buildCategoryItemList() {
    if (_calendarEvent.category == "") {
      _calendarEvent.category = "AMA";
    }
    if (_calendarEvent.color == "") {
      _calendarEvent.color = "green";
    }
    _categoryItems = new List<CategoryItem>();
    _categoryItems.add(CategoryItem(
      title: "AMA",
      colorCode: "green",
      color: Colors.green,
    ));
    _categoryItems.add(CategoryItem(
      title: "Video Call",
      colorCode: "red",
      color: Colors.red,
    ));
    _categoryItems.add(CategoryItem(
      title: "Telegram Party",
      colorCode: "blue",
      color: Colors.blue,
    ));
    _categoryItems.add(CategoryItem(
      title: "Panel",
      colorCode: "orange",
      color: Colors.orange,
    ));
    _categoryItems.add(CategoryItem(
      title: "Meetup",
      colorCode: "purple",
      color: Colors.purple,
    ));
    _categoryItems.add(CategoryItem(
      title: "Conference",
      colorCode: "yellow",
      color: Colors.yellow,
    ));
    _categoryItems.add(CategoryItem(
      title: "Announcements",
      colorCode: "teal",
      color: Colors.teal,
    ));
    _categoryItems.add(CategoryItem(
      title: "Other",
      colorCode: "brown",
      color: Colors.brown,
    ));
  }

  void getUserId() async {
    FirebaseAuthService fas = new FirebaseAuthService();
    String userId = await fas.getUserId();
    setState(() {
      _userId = userId;
    });
  }

  void deleteEvent() async {
    bool success = await _eventService.deleteCalenderEvents(_calendarEvent);

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: success != null ? Text("Success!") : Text("Failed"),
      content: success != null ? Text("Event is deleted successfully!") : Text("Failed delete event!"),
      actions: [
        FlatButton(
          child: Text("Ok"),
          onPressed: () {
            Navigator.pop(context, true);
            Navigator.pop(context, true);
            if (success != null) {
              close();
            }
          },
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool validateInput() {
    if (_txtTitleController.text == "") {
      showValidationMessage("Please enter event title.");
      return false;
    } else if (_txtNotesController.text == "") {
      showValidationMessage("Please enter event notes.");
      return false;
    } else if (_calendarEvent.from == null) {
      showValidationMessage("Please select start time.");
      return false;
    } else if (_calendarEvent.to == null) {
      showValidationMessage("Please select end time.");
      return false;
    } else if (DateTime.now().compareTo(_calendarEvent.from.add(Duration(minutes: 10))) > 0 && _calendarEvent.userId != _userId) {
      showValidationMessage("Event cannnot be in past.");
      return false;
    } else if (_calendarEvent.to.compareTo(_calendarEvent.from) <= 0) {
      showValidationMessage("Please select end time greater start time.");
      return false;
    } else if (_calendarEvent.recurrenceType != "" && _txtRepeats.text == "") {
      showValidationMessage("Please how many time you would like to repleat this event.");
      return false;
    }
    return true;
  }

  void dismissKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void showValidationMessage(String message) {
    dismissKeyboard();
    AlertDialog alert = AlertDialog(
      title: Text("Add New Event"),
      content: Text(message),
      actions: [
        FlatButton(
          child: Text("Ok"),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void saveEvent() async {
    dismissKeyboard();
    _calendarEvent.eventTitle = _txtTitleController.text;
    _calendarEvent.eventNotes = _txtNotesController.text;
    _calendarEvent.isAllDay = false;
    _calendarEvent.approved = await _eventService.validateApprovalCode(_txtApprovalCode.text);
    if (_calendarEvent.recurrent) {
      if (_calendarEvent.recurrenceType == "Daily") {
        _calendarEvent.recurrenceRule = "FREQ=${_calendarEvent.recurrenceType.toUpperCase()};INTERVAL=1;COUNT=${_txtRepeats.text}";
      } else if (_calendarEvent.recurrenceType == "Weekly") {
        String weekDay = DateFormat('EEEE').format(_calendarEvent.from).toUpperCase().substring(0, 2);
        _calendarEvent.recurrenceRule = "FREQ=${_calendarEvent.recurrenceType.toUpperCase()};INTERVAL=1;COUNT=${_txtRepeats.text};BYDAY=$weekDay";
      } else if (_calendarEvent.recurrenceType == "Monthly") {
        _calendarEvent.recurrenceRule =
            "FREQ=${_calendarEvent.recurrenceType.toUpperCase()};INTERVAL=1;COUNT=${_txtRepeats.text};BYMONTHDAY=${_calendarEvent.from.day}";
      }
    } else {
      _calendarEvent.recurrenceRule = "";
    }
    if (validateInput()) {
      CalendarEvent _new = await _eventService.saveCalenderEvents(_calendarEvent);

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: _new != null ? Text("Success!") : Text("Failed"),
        content: _new != null
            ? _calendarEvent.approved
                ? _calendarEvent.userId == _userId
                    ? Text("New event is updated successfully!")
                    : Text("New event is added successfully!")
                : _calendarEvent.userId == _userId
                    ? Text('New event is added successfully!, it will appear when an admin approves it.')
                    : Text('New event is update successfully!, it will appear when an admin approves it.')
            : Text("Failed adding event!"),
        actions: [
          FlatButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.pop(context, true);
              if (_new != null) {
                close();
              }
            },
          ),
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  void close() {
    dismissKeyboard();
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    Global.checkIfDarkModeEnabled(context);
    return Scaffold(
      appBar: AppBar(
        title: _newEvent
            ? Text('Add New Event')
            : _calendarEvent.userId == _userId
                ? Text('Update Details')
                : Text('Event Details'),
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
              close();
            },
          ),
        ],
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30.0, right: 10.0, left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          style: TextStyle(
                            height: 1,
                          ),
                          onChanged: (value) {
                            setState(() {
                              //oneAddress = value;
                            });
                          },
                          enabled: _newEvent || _calendarEvent.userId == _userId,
                          controller: _txtTitleController,
                          decoration: InputDecoration(
                            labelText: "Event Title",
                            hintText: "Event Title",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: _newEvent || _calendarEvent.userId == _userId
                            ? TextField(
                                maxLines: 3,
                                maxLength: 500,
                                onChanged: (value) {
                                  setState(() {
                                    //oneAddress = value;
                                  });
                                },
                                controller: _txtNotesController,
                                decoration: InputDecoration(
                                  labelText: "Event Notes",
                                  hintText: "add http:// or https:// to any links",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                ),
                              )
                            : new SizedBox(
                                height: 150.0,
                                width: 1000,
                                child: Container(
                                  child: SelectableLinkify(
                                    onOpen: (link) async {
                                      if (await canLaunch(link.url)) {
                                        await launch(link.url);
                                      } else {
                                        throw 'Could not launch $link';
                                      }
                                    },
                                    options: LinkifyOptions(
                                      humanize: false,
                                    ),
                                    text: _txtNotesController.text,
                                    style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal,
                                      color: kHmyNormalTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    linkStyle: TextStyle(
                                      color: Colors.blue,
                                    ),
                                    maxLines: 200,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, //
                                        color: Colors.grey.shade300 //              <--- border width here
                                        ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0), //         <--- border radius here
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.0,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  elevation: 4.0,
                  onPressed: () {
                    if (_newEvent || _calendarEvent.userId == _userId) {
                      dismissKeyboard();
                      DatePicker.showDatePicker(
                        context,
                        theme: DatePickerTheme(
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true,
                        minTime: DateTime(2000, 1, 1),
                        maxTime: DateTime(2025, 12, 31),
                        onConfirm: (date) {
                          _date = '${date.year} - ${date.month} - ${date.day}';
                          _calendarEvent.from = new DateTime(date.year, date.month, date.day, _calendarEvent.from.hour, _calendarEvent.from.minute);
                          _calendarEvent.to = _calendarEvent.from.add(Duration(minutes: 30));
                          _startTime = '${_calendarEvent.from.hour} : ${_calendarEvent.from.minute.toString().padLeft(2, '0')}';
                          _endTime = '${_calendarEvent.to.hour} : ${_calendarEvent.to.minute.toString().padLeft(2, '0')}';
                          setState(() {});
                        },
                        currentTime: _calendarEvent.from != null ? _calendarEvent.from : DateTime.now(),
                        locale: LocaleType.en,
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.date_range,
                                    size: 18.0,
                                    color: _newEvent || _calendarEvent.userId == _userId ? kHmyMainColor : kHmyGreyCardColor,
                                  ),
                                  Text(
                                    "  Date",
                                    style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 1,
                                      color: _newEvent || _calendarEvent.userId == _userId ? kHmyMainColor : kHmyGreyCardColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "  $_date",
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1,
                            color: _newEvent || _calendarEvent.userId == _userId ? Colors.black : kHmyGreyCardColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
                SizedBox(
                  height: 2.0,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  elevation: 4.0,
                  onPressed: () {
                    if (_newEvent || _calendarEvent.userId == _userId) {
                      dismissKeyboard();
                      DatePicker.showTimePicker(context,
                          showSecondsColumn: false,
                          theme: DatePickerTheme(
                            containerHeight: 210.0,
                          ),
                          showTitleActions: true, onConfirm: (time) {
                        _calendarEvent.from = time;
                        _calendarEvent.to = _calendarEvent.from.add(Duration(minutes: 30));
                        _startTime = '${time.hour} : ${time.minute.toString().padLeft(2, '0')}';
                        _endTime = '${_calendarEvent.to.hour} : ${_calendarEvent.to.minute.toString().padLeft(2, '0')}';
                        setState(() {});
                      }, currentTime: _calendarEvent.from, locale: LocaleType.en);
                      setState(() {});
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    size: 18.0,
                                    color: _newEvent || _calendarEvent.userId == _userId ? kHmyMainColor : kHmyGreyCardColor,
                                  ),
                                  Text(
                                    " Start",
                                    style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 1,
                                      color: _newEvent || _calendarEvent.userId == _userId ? kHmyMainColor : kHmyGreyCardColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "  $_startTime",
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1,
                            color: _newEvent || _calendarEvent.userId == _userId ? Colors.black : kHmyGreyCardColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
                SizedBox(
                  height: 2.0,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  elevation: 4.0,
                  onPressed: () {
                    if (_newEvent || _calendarEvent.userId == _userId) {
                      dismissKeyboard();
                      DatePicker.showTimePicker(context,
                          showSecondsColumn: false,
                          theme: DatePickerTheme(
                            containerHeight: 210.0,
                          ),
                          showTitleActions: true, onConfirm: (time) {
                        _calendarEvent.to = time;
                        _calendarEvent.from = _calendarEvent.to.add(Duration(minutes: -30));
                        _startTime = '${_calendarEvent.from.hour} : ${_calendarEvent.from.minute.toString().padLeft(2, '0')}';
                        _endTime = '${time.hour} : ${time.minute.toString().padLeft(2, '0')}';
                        setState(() {});
                      }, currentTime: _calendarEvent.to, locale: LocaleType.en);
                      setState(() {});
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    size: 18.0,
                                    color: _newEvent || _calendarEvent.userId == _userId ? kHmyMainColor : kHmyGreyCardColor,
                                  ),
                                  Text(
                                    " End",
                                    style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 1,
                                      color: _newEvent || _calendarEvent.userId == _userId ? kHmyMainColor : kHmyGreyCardColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "  $_endTime",
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1,
                            color: _newEvent || _calendarEvent.userId == _userId ? Colors.black : kHmyGreyCardColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
                SizedBox(
                  height: 2,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  elevation: 4.0,
                  onPressed: () {
                    if (_newEvent || _calendarEvent.userId == _userId) {
                      dismissKeyboard();
                      AlertDialog alert = AlertDialog(
                        title: Text("Select Category"),
                        content: Container(
                          height: 80.0,
                          width: 60,
                          child: CupertinoPicker.builder(
                              itemExtent: 30,
                              scrollController: new FixedExtentScrollController(
                                initialItem: _selectedCategoryIndex,
                              ),
                              childCount: _categoryItems.length,
                              onSelectedItemChanged: (int index) {
                                CategoryItem item = _categoryItems[index];
                                setState(() {
                                  _calendarEvent.category = item.title;
                                  _calendarEvent.color = item.colorCode;
                                  _selectedCategoryIndex = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                CategoryItem item = _categoryItems[index];
                                return CategoryListItem(
                                  title: item.title,
                                  color: item.color,
                                  colorString: item.colorCode,
                                );
                              }),
                        ),
                        actions: [
                          FlatButton(
                            child: Text("Done"),
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                          ),
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.category,
                                    size: 18.0,
                                    color: _newEvent || _calendarEvent.userId == _userId ? kHmyMainColor : kHmyGreyCardColor,
                                  ),
                                  Text(
                                    " ${_calendarEvent.category}",
                                    style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 1,
                                      color: _newEvent || _calendarEvent.userId == _userId ? kHmyMainColor : kHmyGreyCardColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          color: Global.getColorFromString(_calendarEvent.color),
                          width: 40,
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
                SizedBox(
                  height: 2.0,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  elevation: 4.0,
                  onPressed: () {
                    if (_newEvent || _calendarEvent.userId == _userId) {
                      dismissKeyboard();
                      AlertDialog alert = AlertDialog(
                        title: Text("Recurrance"),
                        content: Container(
                          height: 80.0,
                          width: 60,
                          child: CupertinoPicker.builder(
                              itemExtent: 30,
                              scrollController: new FixedExtentScrollController(
                                initialItem: _selectedRecurrenceIndex,
                              ),
                              childCount: _recurrenceItems.length,
                              onSelectedItemChanged: (int index) {
                                String item = _recurrenceItems[index];
                                setState(() {
                                  _calendarEvent.recurrenceType = item;
                                  if (item != "None") {
                                    _calendarEvent.recurrent = true;
                                    _calendarEvent.recurrenceRule = "";
                                  } else {
                                    _calendarEvent.recurrent = false;
                                    _calendarEvent.recurrenceRule = "";
                                  }
                                  _selectedRecurrenceIndex = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                String item = _recurrenceItems[index];
                                return Text(
                                  item,
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: 1,
                                    color: kHmyGreyCardColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }),
                        ),
                        actions: [
                          FlatButton(
                            child: Text("Done"),
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                          ),
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.repeat_rounded,
                                    size: 18.0,
                                    color: _newEvent || _calendarEvent.userId == _userId ? kHmyMainColor : kHmyGreyCardColor,
                                  ),
                                  Text(
                                    " Repeat",
                                    style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 1,
                                      color: _newEvent || _calendarEvent.userId == _userId ? kHmyMainColor : kHmyGreyCardColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "  ${_calendarEvent.recurrenceType}",
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1,
                            color: _newEvent || _calendarEvent.userId == _userId ? Colors.black : kHmyGreyCardColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
                SizedBox(
                  height: 2,
                ),
                _calendarEvent.recurrenceType != "None"
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                style: TextStyle(
                                  height: 1,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    //oneAddress = value;
                                  });
                                },
                                enabled: _newEvent || _calendarEvent.userId == _userId,
                                controller: _txtRepeats,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Repeat for how many times",
                                  hintText: "Repeat for how many times",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                _newEvent || _calendarEvent.userId == _userId
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                style: TextStyle(
                                  height: 1,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    //oneAddress = value;
                                  });
                                },
                                enabled: _newEvent || _calendarEvent.userId == _userId,
                                controller: _txtApprovalCode,
                                decoration: InputDecoration(
                                  labelText: "Approval Code",
                                  hintText: "optional",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  width: 2,
                ),
                _newEvent || _calendarEvent.userId == _userId
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: RawMaterialButton(
                          onPressed: () {
                            saveEvent();
                          },
                          fillColor: kHmyMainColor,
                          constraints: BoxConstraints(minHeight: 50),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          textStyle: TextStyle(fontSize: 16, fontFamily: 'OpenSans', color: Colors.white, fontWeight: FontWeight.w600),
                          child: _newEvent ? Text('Save') : Text('Update'),
                        ),
                      )
                    : Container(),
                SizedBox(
                  width: 2,
                ),
                !_newEvent && _calendarEvent.userId == _userId
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: RawMaterialButton(
                            onPressed: () {
                              deleteEvent();
                            },
                            fillColor: kHmyMainColor,
                            constraints: BoxConstraints(minHeight: 50),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            textStyle: TextStyle(fontSize: 16, fontFamily: 'OpenSans', color: Colors.white, fontWeight: FontWeight.w600),
                            child: Text('Delete')),
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
