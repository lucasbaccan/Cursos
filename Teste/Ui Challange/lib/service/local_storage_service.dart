import 'package:gourmet_mobile/util/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static Future<bool> buscarUsuario() async {
    final SharedPreferences preferencia = await SharedPreferences.getInstance();
    if (preferencia.getString(SharedPreferencesHelper.USER_USERNAME) != null) {
      DateTime data = DateTime.fromMillisecondsSinceEpoch(
        preferencia.getInt(SharedPreferencesHelper.USER_TOKEN_DATE),
      );
      return data.add(Duration(days: 1)).compareTo(DateTime.now()) >= 0;
    }
    return false;
  }
}
