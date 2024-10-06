import 'package:football_app/pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: camel_case_types
class playersDataBase {
  List<Player> listOfAbsent = [];
  List<Player> listOfReady = [];

  final _openBox = Hive.box('dataBox');

  // load data when opened
  void loadData() {
    var data1 = _openBox.get('lp');
    if (data1 != null) {
      listOfAbsent = List<Player>.from(data1);
    } else {
      listOfAbsent = [];
    }
  }

  //load data for the listOfReady
  void loadData2() {
    var data = _openBox.get('lr');
    if (data != null) {
      listOfReady = List<Player>.from(data);
    } else {
      listOfReady = [];
    }
  }

  // void loadData2() {
  //   listOfReady = _openBox.get('lr');
  // }

  //updata the data for the listOfAbsent
  void updateData() {
    _openBox.put('lp', listOfAbsent);
  }

  //updata the data for the listofready
  void updateData2() {
    _openBox.put("lr", listOfReady);
  }
}
