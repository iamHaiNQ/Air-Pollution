import 'package:airpollution/models/entities/account_entity.dart';
import 'package:airpollution/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage {
  static const _user = '_user';

  static Future<String?> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_user);
    } catch (e) {
      logger.e(e);
      return "";
    }
  }

  static void setUser(AccountEntity accountEntity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _user,
      accountEntity.fullName ?? '',
    );
  }

  static void removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_user);
  }
}
