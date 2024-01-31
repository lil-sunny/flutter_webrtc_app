import "dart:convert";
import "package:http/http.dart" as http;

class UserService {
  static Future<List<User>> getUsers() async {
    final url = Uri.parse("http://localhost:3002/graphql");

    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'query': '''
                  query {
            getUsers {
              email
              id
              name
            }
          }
      '''
          }));
      if (response.statusCode == 200) {
        print(response.body);
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<Map<String, dynamic>> usersData =
            result["data"]["getUsers"].cast<Map<String, dynamic>>();
        return usersData
            .map((userData) => User(
                  id: userData["id"],
                  name: userData['name'],
                  email: userData['email'],
                ))
            .toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (err) {
      throw Exception("Network error");
    }
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
