import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class ChannelRankingRepository {
  late SharedPreferences prefs;

  static const _filterKey = 'filter';

  void setFilterIndex(int index) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_filterKey, index);
  }

  Future<int> getFilterIndex() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_filterKey) ?? 0;
  }
}
