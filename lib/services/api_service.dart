import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mufreak/api_consts.dart';


// class ApiService {
//   static Future<void> getModels() async{
//     try {
//        var response = await http.post(
//         Uri.parse(BASE_URL),
//         headers: {
//           'Content-Type' : 'application/json',
//           },
        
//         );

//         Map jsonResponse = jsonDecode(response.body);
//         print("jsonResponse $jsonResponse"); 
//     } catch(e){
//       print("error $e");
//     }
//   }
// }

Future<String> getOpenRouterResponse(String userInput) async {
    var endpoint = "$BASE_URL_OPENR/chat/completions";

    final headers = {
      'Authorization': 'Bearer $API_KEY_OPENR',
      'Content-Type' : 'application/json',
    };

    final body = jsonEncode({
      'model':'deepseek/deepseek-chat-v3-0324:free',
      'messages': [
      {
      "role": "system",
      "content": "You are a helpful assistant for identifying and recognizing the authors of song lyrics fragments. You can also be asked about tracks made by specific author. And you can be asked just about authors."
      },
      {"role": "user", "content": userInput}
    ],
      'max_tokens':100,
      'temperature': 0.7,
    });

    try {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      if (data['choices'] != null && data['choices'][0]['message'] != null) {
        //print(data['choices'][0]['message']['content']);
        return data['choices'][0]['message']['content'];
      } else if (data['choices'] != null && data['choices'][0]['text'] != null) {
        return data['choices'][0]['text'];
      } else {
        return "No answer received from AI.";
      }
    } else {
      return "Error: ${response.body}";
    }
  } catch (e) {
    return "Exception: $e";
  }
  }


/*

curl https://openrouter.ai/api/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer APIKEY" \
  -d '{
  "model": "deepseek/deepseek-prover-v2:free",
  "messages": [
    {
      "role": "user",
      "content": "What is the meaning of life?"
    }
  ]
}'




*/