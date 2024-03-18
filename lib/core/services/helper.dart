

int getDaysBetween({required String fromDate}){
  // Parse the start date string
  DateTime startDate = DateTime.parse(fromDate);
  // Get the current date
  DateTime now = DateTime.now();

  // Calculate the difference in days
  int differenceInDays = startDate.difference(now).inDays;
  return differenceInDays;
}