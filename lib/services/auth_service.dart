import "dart:convert";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:http/http.dart" as http;
// import "package:webtrc_app/services/user_service.dart";

class AuthService {
  Future<void> saveToken(String token) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: "userToken", value: token);
  }

  Future<String?> getToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: "userToken");
  }

  Future<void> saveAuthUser(String userId) async {
    print("save auth user! $userId");
    final storage = FlutterSecureStorage();
    await storage.write(key: "userId", value: userId);
  }

  static Future<String> register(
      String name, String email, String password) async {
    final url = Uri.parse('http://localhost:3002/graphql');
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'query': '''
              mutation {
                register(
                  name: "$name",
                  email: "$email",
                  password: "$password"
                ) {
                  token
                  user {
                    id
                    name
                    email
                  }
                }
              }
            '''
          }));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final token = responseData['data']['register']['token'];

        if (token != null) {
          await AuthService().saveToken(token);

          final user = responseData['data']['register']['user'];
          await AuthService().saveAuthUser(user.toJson());

          return "";
        } else {
          return "Token not found in the response";
        }
      } else {
        return ('Error: ${response.body}');
      }
    } catch (err) {
      print("Error $err");
      return "Network error";
    }
  }

  static Future<String> login(String email, String password) async {
    final url = Uri.parse('http://localhost:3002/graphql');

    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'query': '''
              mutation {
                login(email: "$email", password: "$password") {
                  token,
                  user {
                    id,
                    name,
                    email
                  }
                }
              }
            '''
          }));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData.containsKey("errors")) {
          return "Error: ${responseData['errors'].toString()}";
        } else {
          final userId = responseData['data']['login']['user']['id'];
          if (userId != null) {
            await AuthService().saveAuthUser(userId.toString());
          } else {
            print("User is null. Cannot save to storage.");
          }
          return "";
        }
      } else {
        return "Error: ${response.body}";
      }
    } catch (err) {
      print("Error:  $err");
      return "Network error";
    }
  }
}
