import 'package:flutter/material.dart';

class DateTimeProvider extends ChangeNotifier {
  DateTime? checkInDate;
  TimeOfDay? checkInTime;
  DateTime? checkOutDate;
  TimeOfDay? checkOutTime;

  int numberOfGuests = 1;
  double price = 0;
  double totalPrice = 0;

  void setcheckInDate(DateTime selectedDate) {
    checkInDate = selectedDate;
    calculateTotalPrice();
    notifyListeners();
  }

  void setcheckInTime(TimeOfDay selectedTime) {
    checkInTime = selectedTime;
    notifyListeners();
  }

  void setcheckOutDate(DateTime selectedDate) {
    checkOutDate = selectedDate;
    calculateTotalPrice();
    notifyListeners();
  }

  void setcheckOutTime(TimeOfDay selectedTime) {
    checkOutTime = selectedTime;
    notifyListeners();
  }

  void setBasePrice(double base) {
    price = base;
    calculateTotalPrice();
    notifyListeners();
  }

  void increaseGuests() {
    numberOfGuests++;
    calculateTotalPrice();
    notifyListeners();
  }

  void decreaseGuests() {
    if (numberOfGuests > 1) {
      numberOfGuests--;
      calculateTotalPrice();
      notifyListeners();
    }
  }

  int getNumberOfDays() {
    if (checkInDate != null && checkOutDate != null) {
      int days = checkOutDate!.difference(checkInDate!).inDays;
      return days > 0 ? days : 1;
    }
    return 1;
  }

  void calculateTotalPrice() {
    double guestMultiplier;
    if (numberOfGuests <= 3) {
      guestMultiplier = 1.0;
    } else if (numberOfGuests <= 5) {
      guestMultiplier = 1.25;
    } else if (numberOfGuests <= 7) {
      guestMultiplier = 1.5;
    } else if (numberOfGuests <= 9) {
      guestMultiplier = 1.75;
    } else if (numberOfGuests <= 11) {
      guestMultiplier = 2.0;
    } else if (numberOfGuests <= 13) {
      guestMultiplier = 2.25;
    } else {
      guestMultiplier = 2.5;
    }

    double dayMultiplier = 1 + ((getNumberOfDays() - 1) * 0.75);

    totalPrice = price * guestMultiplier * dayMultiplier;
  }
}
