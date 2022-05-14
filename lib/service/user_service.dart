import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class SignUpService {
  static Future singUp({Map<String, dynamic>? reqModel}) async {
    http.Response response = await http.post(
      Uri.parse('https://codelineinfotech.com/student_api/User/signup.php'),
      body: reqModel,
    );
    log('Response ====== ${jsonDecode(response.body)}');
    return jsonDecode(response.body);
  }
}

class SigninService {
  static Future<bool> singin(Map<String, dynamic> reqModel) async {
    http.Response response = await http.post(
      Uri.parse('https://codelineinfotech.com/student_api/User/login.php'),
      body: reqModel,
    );
    var result = jsonDecode(response.body);
    log('Response ====== ${jsonDecode(response.body)}');
    return result['status'];
  }
}
