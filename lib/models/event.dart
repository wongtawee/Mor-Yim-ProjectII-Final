import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

class EventModel extends FirebaseDatabase {
  final String id;
  final String title;
  final String description;
  final DateTime eventDate;

  EventModel({this.id, this.title, this.description, this.eventDate}) : super();

  factory EventModel.fromMap(Map data) {
    return EventModel(
      title: data['title'],
      description: data['description'],
      eventDate: data['eventdate'],
    );
  }

  factory EventModel.fromDS(String id, Map<String, dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'],
      description: data['description'],
      eventDate: data['eventdate'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "eventdate": eventDate,
      "id": id,
    };
  }
}
