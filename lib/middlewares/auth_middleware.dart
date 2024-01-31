import "package:flutter_secure_storage/flutter_secure_storage.dart";

class AuthMiddleware {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<bool> isAuthenticated() async {
    final token = await storage.read(key: "authToken");
    final user = await storage.read(key: "user");
    if (token != null && user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> authenticate() async {
    final isAuth = await isAuthenticated();

    if (isAuth) {
      return "";
    } else {
      return "Not authenticated user";
    }
  }
}
