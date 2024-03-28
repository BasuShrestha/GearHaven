import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? prefs;
  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  static int? getUserId() {
    return prefs != null ? prefs!.getInt('userId') : null;
  }

  static void setUserId(int userId) {
    prefs!.setInt('userId', userId);
  }

  static String? getFcmToken() {
    return prefs != null ? prefs!.getString('fcmToken') : null;
  }

  static void setFcmToken(String fcmToken) {
    prefs!.setString('fcmToken', fcmToken);
  }

  static void removeFcmToken() {
    prefs!.remove('fcmToken');
  }

  static String? getAccessToken() {
    return prefs != null ? prefs!.getString('accessToken') : null;
  }

  static void setAccessToken(String accessToken) {
    prefs!.setString('accessToken', accessToken);
  }

  static void removeAccessToken() {
    prefs!.remove('accessToken');
  }

  static String? getRefreshToken() {
    return prefs != null ? prefs!.getString('refreshToken') : null;
  }

  static void setRefreshToken(String refreshToken) {
    prefs!.setString('refreshToken', refreshToken);
  }

  static void removeRefreshToken() {
    prefs!.remove('refreshToken');
  }

  static String? getCart() {
    return prefs != null ? prefs!.getString('cart') : null;
  }

  static void setCart(String cart) {
    prefs!.setString('cart', cart);
  }

  static String? getWishlist() {
    return prefs != null ? prefs!.getString('wishlist') : null;
  }

  static void setWishlist(String wishlist) {
    prefs!.setString('wishlist', wishlist);
  }

  static void removeAll() async {
    await prefs!.clear();
  }
}
