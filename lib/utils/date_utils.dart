// today in number of days
int dayOfYear() {
  final now = DateTime.now();
  final todayInDays = now.difference(DateTime(now.year, 1, 1, 0, 0)).inDays + 1;
  return todayInDays;
}

// convert DateTime into readable format [mmm dd, yyyy] and display if the date provided is today or yesterday
String getDynamicDateString(DateTime date) {
  DateTime now = DateTime.now();
  bool isToday = date.year == now.year // check if provided date is equals [now]
  && date.month == now.month
  && date.day == now.day;

  DateTime yesterday = now.subtract(const Duration(days: 1));
  bool isYesterday = date.year == yesterday.year // check if provided date is equals to [yesterday]
  && date.month == yesterday.month
  && date.day == yesterday.day;
  
  if(isToday) {
    return 'today';
  } else if(isYesterday) {
    return 'yesterday';
  } else {
    switch(date.month) {
      case 1:
        return "Jan ${date.day}, ${date.year}";
      case 2:
        return "Feb ${date.day}, ${date.year}";
      case 3:
        return "Mar ${date.day}, ${date.year}";
      case 4:
        return "Apr ${date.day}, ${date.year}";
      case 5:
        return "May ${date.day}, ${date.year}";
      case 6:
        return "Jun ${date.day}, ${date.year}";
      case 7:
        return "Jul ${date.day}, ${date.year}";
      case 8:
        return "Aug ${date.day}, ${date.year}";
      case 9:
        return "Sep ${date.day}, ${date.year}";
      case 10:
        return "Oct ${date.day}, ${date.year}";
      case 11:
        return "Nov ${date.day}, ${date.year}";
      case 12:
        return "Dec ${date.day}, ${date.year}";
      default:
        return '';
    }
  }
}

// convert DateTime into readable format [mmm dd, yyyy] only
String getDateString(DateTime date) {
  switch(date.month) {
    case 1:
      return "Jan ${date.day}, ${date.year}";
    case 2:
      return "Feb ${date.day}, ${date.year}";
    case 3:
      return "Mar ${date.day}, ${date.year}";
    case 4:
      return "Apr ${date.day}, ${date.year}";
    case 5:
      return "May ${date.day}, ${date.year}";
    case 6:
      return "Jun ${date.day}, ${date.year}";
    case 7:
      return "Jul ${date.day}, ${date.year}";
    case 8:
      return "Aug ${date.day}, ${date.year}";
    case 9:
      return "Sep ${date.day}, ${date.year}";
    case 10:
      return "Oct ${date.day}, ${date.year}";
    case 11:
      return "Nov ${date.day}, ${date.year}";
    case 12:
      return "Dec ${date.day}, ${date.year}";
    default:
      return '';
  }
}