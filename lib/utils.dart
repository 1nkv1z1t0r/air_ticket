import 'package:intl/intl.dart';

extension IntUtils on int {
  String splitByThousands() {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]} ',
    );
  }
}

final formatterHHmm = DateFormat('HH:mm');
final formatterDDMM = DateFormat('d MMM', 'ru');
final formatterEE = DateFormat(', EEE', 'ru');

String differenceHHmm(DateTime date1, DateTime date2) {
  final dataHours = date1.difference(date2).inHours;
  final dataMinutes = date1.difference(date2).inMinutes - (dataHours * 60);
  return "$dataHoursч $dataMinutesмин";
}
