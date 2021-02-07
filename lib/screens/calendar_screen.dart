import 'package:HarmonyHub/models/calendar_event.dart';
import 'package:HarmonyHub/screens/event_details_screen.dart';
import 'package:HarmonyHub/services/events_service.dart';
import 'package:HarmonyHub/utilities/constants.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalendarScreen> {
  CalendarController _controller;
  TextEditingController _eventController;
  EventService _eventService;
  DateTime _selectedDate;
  List<CalendarEvent> _events;
  bool dataLoading;
  MeetingDataSource _dataSource;
  DateTime _visibleStartDate;
  DateTime _visibleEndDate;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _eventService = EventService();
    _events = [];
    _dataSource = MeetingDataSource(_events);
    dataLoading = false;
    _selectedDate = DateTime.now();
  }

  void getCalendarEvents(DateTime startDate, DateTime endDate) async {
    _events = await _eventService.getCalenderEvents(startDate, endDate);
    setState(() {
      _dataSource = MeetingDataSource(_events);
    });
  }

  @override
  Widget build(BuildContext context) {
    Global.checkIfDarkModeEnabled(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Image.asset(
            'assets/app_icon.png',
          ),
        ),
        actions: [
          new IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              getCalendarEvents(_visibleStartDate, _visibleEndDate);
            },
          ),
        ],
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: SfCalendar(
        headerStyle: CalendarHeaderStyle(
          textAlign: TextAlign.center,
          backgroundColor: kHmyMainColor,
          textStyle: GoogleFonts.nunito(
            fontSize: 25,
            fontStyle: FontStyle.normal,
            letterSpacing: 1,
            color: Color(0xFFff5eaea),
            fontWeight: FontWeight.w500,
          ),
        ),
        view: CalendarView.month,
        monthViewSettings: MonthViewSettings(showAgenda: true),
        firstDayOfWeek: 7,
        dataSource: MeetingDataSource(_events),
        initialSelectedDate: DateTime.now(),
        onTap: (calendarTapDetails) {
          _selectedDate = calendarTapDetails.date;
          if (calendarTapDetails.appointments.length == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailsScreen(
                  newEvent: false,
                  calendarEvent: calendarTapDetails.appointments[0],
                ),
              ),
            ).then((value) => getCalendarEvents(_visibleStartDate, _visibleEndDate));
          }
        },
        onViewChanged: (ViewChangedDetails details) {
          if (details.visibleDates.length > 0) {
            _visibleStartDate = details.visibleDates[0];
            _visibleEndDate = details.visibleDates[details.visibleDates.length - 1];
          }
          getCalendarEvents(_visibleStartDate, _visibleEndDate);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailsScreen(
                newEvent: true,
                calendarEvent: CalendarEvent(
                  eventTitle: "",
                  eventDescription: "",
                  eventNotes: "",
                  from: _selectedDate,
                  to: _selectedDate.add(Duration(minutes: 30)),
                  isAllDay: false,
                  category: "AMA",
                  color: "green",
                  recurrent: false,
                  recurrenceRule: "",
                  recurrenceType: "None",
                ),
              ),
            ),
          ).then((value) => getCalendarEvents(_visibleStartDate, _visibleEndDate));
        },
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<CalendarEvent> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventTitle;
  }

  @override
  Color getColor(int index) {
    return Global.getColorFromString(appointments[index].color);
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }

  @override
  String getRecurrenceRule(int index) {
    return appointments[index].recurrenceRule;
  }
}
