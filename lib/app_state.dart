import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _favFoodList = prefs.getStringList('ff_favFoodList') ?? _favFoodList;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _searchActive = false;
  bool get searchActive => _searchActive;
  set searchActive(bool value) {
    _searchActive = value;
  }

  List<String> _favFoodList = [];
  List<String> get favFoodList => _favFoodList;
  set favFoodList(List<String> value) {
    _favFoodList = value;
    prefs.setStringList('ff_favFoodList', value);
  }

  void addToFavFoodList(String value) {
    favFoodList.add(value);
    prefs.setStringList('ff_favFoodList', _favFoodList);
  }

  void removeFromFavFoodList(String value) {
    favFoodList.remove(value);
    prefs.setStringList('ff_favFoodList', _favFoodList);
  }

  void removeAtIndexFromFavFoodList(int index) {
    favFoodList.removeAt(index);
    prefs.setStringList('ff_favFoodList', _favFoodList);
  }

  void updateFavFoodListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    favFoodList[index] = updateFn(_favFoodList[index]);
    prefs.setStringList('ff_favFoodList', _favFoodList);
  }

  void insertAtIndexInFavFoodList(int index, String value) {
    favFoodList.insert(index, value);
    prefs.setStringList('ff_favFoodList', _favFoodList);
  }

  String _extractedText = '';
  String get extractedText => _extractedText;
  set extractedText(String value) {
    _extractedText = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
