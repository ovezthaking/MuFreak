import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mufreak/api_consts.dart';

class ApiService {
  static Future<void> getModels() async{
    try {
       var response = await http.get(
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {
          'Authorization' : 'Bearer $API_KEY',
          'Content-Type' : 'application/json',
          'Accept' : '*/*',
          },
        
        );

        Map jsonResponse = jsonDecode(response.body);
        print("jsonResponse $jsonResponse"); 
    } catch(e){
      print("error $e");
    }
  }
}


