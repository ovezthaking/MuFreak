import 'package:flutter/material.dart';
import 'package:mufreak/constants.dart';
import 'package:mufreak/services/api_service.dart';

class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
      body: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  margin: const EdgeInsets.only(top:4),
                  decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Container(
                height: 123,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage(AiAssistantImage.png)),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            margin: EdgeInsets.symmetric(horizontal: 40,).copyWith(
              top: 50,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(20).copyWith(
                topLeft: Radius.zero,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text("Hello, what can I do for you today?", style: TextStyle(
                fontSize: 25,
              ),),
            ),
          ),
          ListTile(
                title: TextFormField(
                  //controller: ,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Write your comment...',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 28, 133, 33)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 28, 133, 33)),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () async {
                    try {
                      await ApiService.getModels();
                    }
                    catch(e){
                      print("error $e");
                    }
                  } ,
                  child: const Text(
                    'Send',
                    style: TextStyle(fontSize: 16, color: Colors.white,),
                    ),
                ),
              ),
        ],
      ),
    );
  }
}