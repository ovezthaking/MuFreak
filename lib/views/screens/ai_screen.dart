import 'package:flutter/material.dart';
import 'package:mufreak/constants.dart';

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
          )
        ],
      ),
    );
  }
}