import 'package:football_app/pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:football_app/pages/home.dart';

// ignore: camel_case_types
class playersDataBase {
  List<Player> listOfAbsent = [
  ];
  List<Player> listOfReady = [
  ];

  final _openBox = Hive.box('dataBox');

  // load data when opened
  void loadData() {
    listOfAbsent = _openBox.get('lp');
  }

  //load data for the listOfReady
  void loadData2() {
    listOfReady = _openBox.get('lr');
  }

  //updata the data for the listOfAbsent
  void updateData() {
    _openBox.put('lp', listOfAbsent);
  }

  //updata the data for the listofready
  void updateData2() {
    _openBox.put("lr", listOfReady);
  }
}
