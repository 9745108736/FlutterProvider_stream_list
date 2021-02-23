import 'package:intl/intl.dart';

class Utils {
  static convertDateTime({String dT}) {
    DateTime now = DateTime.now();
    print(now);
    print(dT);
    DateTime _dt = DateTime.parse(dT);
    String formattedDate = DateFormat('EEE, MMM d, ' 'yy').format(_dt);
    print("Converted date time - ${formattedDate}");
    var diff = _dt.difference(now);
    print("dif - ${diff.inDays}");
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = formattedDate;
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }
    print("Converted date - $time");
    return time;
  }
}
