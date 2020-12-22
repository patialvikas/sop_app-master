import 'package:flutter/foundation.dart';
import '../../CRAP/DeptModel.dart';
import '../../CRAP/DeptModel.dart';
import '../../models/UserModel.dart';
import '../../models/UserModel.dart';
import '../../models/UserModel.dart';

class UserProvider with ChangeNotifier {
  Dataa _user = new Dataa();

  Dataa get user => _user;

  void setUser(Dataa user) {
    _user = user;
    notifyListeners();
  }
}