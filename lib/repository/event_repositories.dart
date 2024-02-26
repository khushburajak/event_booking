import 'dart:io';

import 'package:event_booking/api/event_api.dart';
import 'package:event_booking/models/event.dart';
import 'package:event_booking/response/get_event_response.dart';

class EventRepository {
  // Event Repository for Creating Event By Authenticated User
  Future<bool> addEvent(File? file, Event event) async {
    return EventAPI().addEvent(file, event);
  }

  // Event Repository for Getting Event By All Users
  Future<EventResponse?> getEvents() async {
    return EventAPI().getEvents();
  }

  // Event Repository for Getting Event By User
  Future<EventResponse?> getEventsByUser() async {
    return EventAPI().getEventsByUser();
  }

  // Event Repository for Updating Event By User
  Future<bool> updateEvent(File? file, Event event) async {
    return EventAPI().updateEvent(file, event);
  }

  // Event Repository for Attending Event By User
  Future<bool> attendEvent(eventID) async {
    return EventAPI().attendEvent(eventID);
  }

  // Event Repository for Getting Attending Event By User
  Future<EventResponse?> attendingEvent() async {
    return EventAPI().attendingEvent();
  }

  // Event Repository for Like Event By User
  Future<bool> likeEvent(eventID) async {
    return EventAPI().likeEvent(eventID);
  }
}
