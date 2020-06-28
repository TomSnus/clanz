import 'package:cloud_firestore/cloud_firestore.dart';

class DateTimeUtils {
  static DateTime getDateTimeFromTimestamp(Timestamp stamp) {
    return stamp.toDate();
  }
}
