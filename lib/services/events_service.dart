import 'package:HarmonyHub/models/calendar_event.dart';
import 'package:HarmonyHub/services/firebase_auth.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

class EventService {
  final String calenderEventsTableName = "dev_calendar_events"; //"calender_events";
  Future<List<CalendarEvent>> getCalenderEvents(DateTime startDate, DateTime endDate) async {
    await Firebase.initializeApp();
    DateFormat dateFormat = new DateFormat("E, d MMM y H:m:s");
    FirebaseAuthService fas = new FirebaseAuthService();
    String userId = await fas.getUserId();
    String projectId = await Global.getProjectId();
    if (userId != null) {
      QuerySnapshot visibleDatesEvents = await FirebaseFirestore.instance
          .collection(calenderEventsTableName)
          .where('project_id', isEqualTo: projectId)
          .where('start_date', isGreaterThanOrEqualTo: startDate)
          .where('start_date', isLessThanOrEqualTo: endDate)
          .get();
      Global.events.clear();
      List<String> docIds = new List<String>();
      for (int i = 0; i < visibleDatesEvents.docs.length; i++) {
        var element = visibleDatesEvents.docs[i];
        if (element['approved']) {
          docIds.add(element.id);
          CalendarEvent calendarEvent = CalendarEvent(
            docId: element.id,
            eventTitle: element['title'],
            eventDescription: element['details'],
            eventNotes: element['notes'],
            isAllDay: element['isAllDay'],
            approved: element['approved'],
            from: element['start_date'].toDate(),
            to: element['end_date'].toDate(),
            userId: element['userId'],
            color: element['color'],
            category: element['category'],
            recurrenceType: element['recurrence_type'],
            recurrenceRule: element['recurrence_rule'],
            recurrent: element['recurrent'],
          );
          Global.events.add(calendarEvent);
        }
      }
      QuerySnapshot recurrentEvents = await FirebaseFirestore.instance.collection(calenderEventsTableName).where('recurrent', isEqualTo: true).get();

      for (int i = 0; i < recurrentEvents.docs.length; i++) {
        var element = recurrentEvents.docs[i];
        if (element['approved']) {
          if (!docIds.contains(element.id)) {
            CalendarEvent calendarEvent = CalendarEvent(
              docId: element.id,
              eventTitle: element['title'],
              eventDescription: element['details'],
              eventNotes: element['notes'],
              isAllDay: element['isAllDay'],
              approved: element['approved'],
              from: element['start_date'].toDate(),
              to: element['end_date'].toDate(),
              userId: element['userId'],
              color: element['color'],
              category: element['category'],
              recurrenceType: element['recurrence_type'],
              recurrenceRule: element['recurrence_rule'],
              recurrent: element['recurrent'],
            );
            Global.events.add(calendarEvent);
          }
        }
      }
    }
    return Global.events;
  }

  Future<CalendarEvent> saveCalenderEvents(CalendarEvent event) async {
    DateFormat dateFormat = new DateFormat("E, d MMM y H:m:s");
    FirebaseAuthService fas = new FirebaseAuthService();
    String userId = await fas.getUserId();
    String projectId = await Global.getProjectId();
    if (userId != null) {
      bool success = false;
      if (event.docId != null) {
        await FirebaseFirestore.instance.collection(calenderEventsTableName).doc(event.docId).update({
          'approved': event.approved,
          'color': event.color,
          'category': event.category,
          'details': event.eventDescription,
          'isAllDay': event.isAllDay,
          'notes': event.eventNotes,
          'title': event.eventTitle,
          'userId': userId,
          'start_date': event.from,
          'end_date': event.to,
          'recurrence_type': event.recurrenceType,
          'recurrence_rule': event.recurrenceRule,
          'recurrent': event.recurrent
        }).then((value) => success = true);
        if (success) {
          return event;
        } else {
          return null;
        }
      } else {
        DocumentReference _new = await FirebaseFirestore.instance.collection(calenderEventsTableName).add(
          {
            'approved': event.approved,
            'color': event.color,
            'category': event.category,
            'details': event.eventDescription,
            'isAllDay': event.isAllDay,
            'notes': event.eventNotes,
            'title': event.eventTitle,
            'userId': userId,
            'start_date': event.from,
            'end_date': event.to,
            'recurrence_type': event.recurrenceType,
            'recurrence_rule': event.recurrenceRule,
            'recurrent': event.recurrent,
            'project_id': projectId
          },
        );
        if (_new.id != null) {
          event.docId = _new.id;
          return event;
        } else {
          return null;
        }
      }
    }
    return event;
  }

  Future<bool> deleteCalenderEvents(CalendarEvent event) async {
    bool success = false;
    FirebaseAuthService fas = new FirebaseAuthService();
    String userId = await fas.getUserId();
    if (userId != null) {
      if (event.docId != null) {
        await FirebaseFirestore.instance.collection(calenderEventsTableName).doc(event.docId).delete().then((value) => success = true);
      }
    }
    return success;
  }

  Future<bool> validateApprovalCode(String code) async {
    bool valid = false;

    FirebaseAuthService fas = new FirebaseAuthService();
    String userId = await fas.getUserId();
    if (userId != null) {
      QuerySnapshot codes = await FirebaseFirestore.instance.collection('approval_codes').where("code", isEqualTo: code).get();
      if (codes.docs.length > 0) {
        valid = codes.docs[0].data()['active'];
      }
    }
    return valid;
  }
}
