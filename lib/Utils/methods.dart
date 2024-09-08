class MyMethods {
  static String roundDecimalNo(double? number, int noOfDecimal) {
    if (number != null) {
      return number.toStringAsFixed(noOfDecimal);
    }
    return "";
  }

  static String yearFromString(String? dateString) {
    if (dateString != null) {
      try {
        return DateTime.parse(dateString).year.toString();
      } catch (e) {
        return "";
      }
    }
    return "";
  }

  static String getTimeString(int? value) {
    if (value != null) {
      try {
        final int hour = value ~/ 60;
        final int minutes = value % 60;

        if (hour != 0 && minutes != 0) {
          return '${hour.toString().padLeft(1, "0")}h ${minutes.toString().padLeft(2, "0")}m';
        }
      } catch (e) {
        return "";
      }
    }
    return "";
  }
}
