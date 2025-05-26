import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mufreak/api_consts.dart';


class ApiService {
  static Future<void> getModels() async{
    try {
       var response = await http.post(
        Uri.parse(BASE_URL),
        headers: {
          'Content-Type' : 'application/json',
          },
        
        );

        Map jsonResponse = jsonDecode(response.body);
        print("jsonResponse $jsonResponse"); 
    } catch(e){
      print("error $e");
    }
  }

  Future<String> getOpenRouterResponse(String userInput) async {
    var endpoint = BASE_URL_OPENR;

    final headers = {
      'Authorization': 'Bearer $API_KEY_OPENR'
      'Content-Type' : 'application/json',
    };

    final body = jsonEncode({
      'model':'deepseek/deepseek-prover-v2:free',
      'prompt': userInput,
      'max_tokens':100,
      'temperature': 0.7,
    });
  }
}

