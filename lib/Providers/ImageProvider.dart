import 'package:flutter/cupertino.dart';

class ImageProvider extends ChangeNotifier{
  var address = ['address1', 'address2', 'address3'];
  String getmainPhoto() {
    return address[0];
  }
  String getfirstSmall() {
    return address[1];
  }
  String getSecondSmall() {
    return address[2];
  }
  void setFirst() {
    final temp = address[0];
    address[0] = address[1];
    address[1] = temp;

    notifyListeners();
  }

  void setSecond() {
    final temp = address[0];
    address[0] = address[2];
    address[2] = temp;

    notifyListeners();
  }


}