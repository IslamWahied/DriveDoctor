

int getDifferenceBetweenTwoNumbers(
    {required int firstNumber, required int secondNumber   }) {


  var result  = firstNumber - secondNumber;
  return result.toInt();
}


int getPercentageDifference(
    {required int currentCarKilometers, required int serviceKilometers, required int lastServiceKilometersMade}) {
  // Calculate kilometers since last gear change
  int kilometersSinceChange = currentCarKilometers - lastServiceKilometersMade;

  // Calculate total coach lifespan
  int coachLifespan = serviceKilometers;

  // Calculate percentage of coach age
  double percentage = (kilometersSinceChange / coachLifespan) * 100;

  // Ensure percentage is within 0-100 range
  if (percentage < 0) {
    percentage = 0;
  } else if (percentage > 100) {
    percentage = 100;
  }

  // Invert the percentage to represent age instead of remaining life
  percentage = 100 - percentage;

  return percentage.toInt();

}

int getDaysBetween({required String fromDate}){
  // Parse the start date string
  DateTime startDate = DateTime.parse(fromDate);
  // Get the current date
  DateTime now = DateTime.now();

  // Set time to midnight for both dates
  startDate = DateTime(startDate.year, startDate.month, startDate.day);
  now = DateTime(now.year, now.month, now.day);

  // Calculate the difference in days
  int differenceInDays = startDate.difference(now).inDays.abs();
  return differenceInDays;
}