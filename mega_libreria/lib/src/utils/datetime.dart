String formatDatetime(String date, String time) {
  final datetime = DateTime.now();

  final currentDate = "${datetime.day}/${datetime.month}/${datetime.year}";

  if (currentDate == DMY(date)) {
    return "Hoy a las ${HM(time)}";
  }

  return "${DMY(date)} a las ${HM(time)}";
}

// ignore: non_constant_identifier_names
String DMY(String date) {
  final datetime = DateTime.now();

  final currentDate =
      "${datetime.year}-${validateFormat(datetime.month)}-${validateFormat(datetime.day)}";

  if (currentDate == date) {
    return "Hoy";
  }

  return date.split("-").reversed.join("/");
}

// ignore: non_constant_identifier_names
String HM(String time) {
  final seg = time.split(":");

  return seg[0] + ":" + seg[1];
}

String validateFormat(dynamic value) {
  if (value is String) {
    return int.parse(value) < 10 ? "0" + value : value;
  }

  return value < 10 ? "0" + value.toString() : value.toString();
}
