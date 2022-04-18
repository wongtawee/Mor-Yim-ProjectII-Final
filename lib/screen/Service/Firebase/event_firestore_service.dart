import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:moryim/models/event.dart';

DatabaseService<EventModel> eventDBS = DatabaseService<EventModel>(
    "Appointment",
    fromDS: (id, data) => EventModel.fromDS(id, data),
    toMap: (event) => event.toMap());
