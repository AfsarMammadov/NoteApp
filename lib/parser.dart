
String dateParser(String date){
  String year=date.substring(0,4);
  String month=date.substring(5,7);
  String day=date.substring(8,10);
  String hour=date.substring(11,16);

  String parsedDate='$day-$month-$year  $hour';
  return parsedDate;
}