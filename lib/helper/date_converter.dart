import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../localization/controllers/localization_controller.dart';

class DateConverter {
  static Locale? get _locale {
    if (Get.context == null) return null;
    return Provider.of<LocalizationController>(Get.context!).locale;
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss', _locale?.languageCode)
        .format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy', _locale?.languageCode).format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-dd hh:mm:ss", _locale?.languageCode).parse(dateTime);
  }

  static String dateStringMonthYear(DateTime? dateTime) {
    return DateFormat('d MMM,y', _locale?.languageCode).format(dateTime!);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS', _locale?.languageCode)
        .parse(dateTime, true)
        .toLocal();
  }

  static String localDateToIsoStringAMPM(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy', _locale?.languageCode).format(dateTime.toLocal());
  }

  static String supportTicketDateFormat(DateTime dateTime) {
    return DateFormat('h:mm a dd MMM,yyyy', _locale?.languageCode).format(dateTime.toLocal());
  }

  static String localDateToIsoStringAMPMOrder(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, h:mm a ', _locale?.languageCode).format(dateTime.toLocal());
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('HH:mm', _locale?.languageCode).format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd:MM:yy', _locale?.languageCode).format(isoStringToLocalDate(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss', _locale?.languageCode).format(dateTime.toLocal());
  }

  static String isoStringToLocalDateAndTime(String dateTime) {
    return DateFormat('dd-MMM-yyyy hh:mm a', _locale?.languageCode)
        .format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateAndTimeConversation(String dateTime) {
    return DateFormat('dd MMM yyyy \'at\' ${_timeFormatter()}', _locale?.languageCode)
        .format(isoUtcStringToLocalDate(dateTime));
  }

  static DateTime isoUtcStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS', _locale?.languageCode)
        .parse(dateTime, true)
        .toLocal();
  }

  static String dateFormatForWalletBonus(String dateTime) {
    return DateFormat('dd MMM, yyyy', _locale?.languageCode).format(isoStringToLocalDate(dateTime));
  }

  static String dateTimeStringToDateTime(String dateTime) {
    return DateFormat('dd MMM, yyyy', _locale?.languageCode)
        .format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dateTime));
  }

  static String dateTimeStringToDateAndTime(String dateTime) {
    return DateFormat('hh:mm a, dd MMM yyyy', _locale?.languageCode)
        .format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dateTime));
  }

  static String dateTimeStringToMonthDateAndTime(String dateTime) {
    return DateFormat('MMMM d, yyyy', _locale?.languageCode)
        .format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dateTime));
  }

  static String refundDateTime(String dateTime) {
    return DateFormat('dd MMM yyyy', _locale?.languageCode)
        .format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dateTime));
  }

  static String estimatedDateYear(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy', _locale?.languageCode).format(dateTime);
  }

  static String inboxLocalDateToIsoStringAMPM(DateTime dateTime) {
    return DateFormat('${_timeFormatter()} | dd-MMM-yyyy ', _locale?.languageCode)
        .format(dateTime.toLocal());
  }

  static DateTime isoUtcStringToLocalTimeOnly(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS', _locale?.languageCode)
        .parse(dateTime, true)
        .toLocal();
  }

  static String convertStringTimeToDate(DateTime time) {
    return DateFormat('EEE \'at\' ${_timeFormatter()}', _locale?.languageCode).format(time.toLocal());
  }

  static String convertStringTimeToDateChatting(DateTime time) {
    return DateFormat('EEE \'at\' ${_timeFormatter()}', _locale?.languageCode).format(time.toLocal());
  }

  static String convert24HourTimeTo12HourTimeWithDay(
      DateTime time, bool isToday) {
    if (isToday) {
      return DateFormat('\'Today at\' ${_timeFormatter()}', _locale?.languageCode).format(time);
    } else {
      return DateFormat('\'Yesterday at\' ${_timeFormatter()}', _locale?.languageCode).format(time);
    }
  }

  static String convert24HourTimeTo12HourTime(DateTime time) {
    return DateFormat(_timeFormatter(), _locale?.languageCode).format(time);
  }

  static String _timeFormatter() {
    return '24';
  }

  static String customTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(const Duration(minutes: 1));
    DateTime localDateTime = dateTime.toLocal();

    if (!localDateTime.difference(justNow).isNegative) {
      return 'just now';
    }

    String roughTimeString = DateFormat('jm').format(dateTime);

    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return roughTimeString;
    }

    DateTime yesterday = now.subtract(const Duration(days: 1));

    if (localDateTime.day == yesterday.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'yesterday';
    }

    if (now.difference(localDateTime).inDays < 4) {
      String weekday = DateFormat('EEEE').format(dateTime.toLocal());

      return weekday;
    }

    return localDateToIsoStringAMPM(dateTime);
  }

  static String compareDates(String inputDate) {
    DateTime currentDate = DateTime.now();
    DateTime parsedDate = DateTime.parse(inputDate);

    Duration difference = currentDate.difference(parsedDate);
    int hoursDifference = difference.inHours;
    int daysDifference = difference.inDays;

    if (hoursDifference < 1) {
      return DateFormat('hh:mm a').format(parsedDate);
    } else if (hoursDifference >= 1 && hoursDifference <= 23) {
      return '$hoursDifference ${getTranslated("hr ago", Get.context!)}';
    } else if (daysDifference == 1) {
      return '${getTranslated("yesterday", Get.context!)}';
    } else if (daysDifference >= 2 && daysDifference <= 7) {
      return '$daysDifference ${getTranslated("days_ago", Get.context!)}';
    } else {
      return DateFormat('MM/dd/yyyy').format(parsedDate);
    }
  }

  static int countDays(DateTime? dateTime) {
    final startDate = dateTime!;
    final endDate = DateTime.now();
    final difference = endDate.difference(startDate).inDays;
    return difference;
  }
}
