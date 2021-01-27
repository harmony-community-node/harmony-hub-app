class CalendarEvent {
  CalendarEvent({
    this.docId,
    this.eventTitle,
    this.from,
    this.to,
    this.color,
    this.category,
    this.isAllDay,
    this.eventNotes,
    this.eventDescription,
    this.approved,
    this.userId,
    this.recurrent,
    this.recurrenceRule,
    this.recurrenceType,
    this.projectCode,
  });

  String docId;
  String eventTitle;
  String eventDescription;
  String eventNotes;
  String userId;
  DateTime from;
  DateTime to;
  String color;
  bool isAllDay;
  bool approved;
  String category;
  bool recurrent;
  String recurrenceRule;
  String recurrenceType;
  String projectCode;
}
