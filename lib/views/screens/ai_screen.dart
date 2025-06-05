import 'package:flutter/material.dart';
import 'package:mufreak/constants.dart';
import 'package:mufreak/services/api_service.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  TextEditingController controller = TextEditingController();
  String answer = '';

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  void _askAi() async {
    String theAnswer = await getOpenRouterResponse(controller.text);
    setState(() {
       answer = theAnswer;
    });
  }

  // ...existing code...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Scrollowalna część z dymkami
          Expanded(
            child: SingleChildScrollView(
              child: Column(
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
                  
                  // Dymek AI - zawsze widoczny
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 40,).copyWith(
                      top: 40,
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
                        color: Colors.white,
                      ),),
                    ),
                  ),
                  
                  // Dymek użytkownika - tylko gdy napisał coś
                  if (controller.text.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 40,).copyWith(
                        top: 40,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor,
                        ),
                        borderRadius: BorderRadius.circular(20).copyWith(
                          topRight: Radius.zero,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(controller.text, style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),),
                      ),
                    ),
                  
                  // Dymek odpowiedzi AI - tylko gdy jest odpowiedź
                  if (answer.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 40,).copyWith(
                        top: 40,
                        bottom: 20, // Dodaj margines na dole
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor,
                        ),
                        borderRadius: BorderRadius.circular(20).copyWith(
                          topLeft: Radius.zero,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(answer, style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),),
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          // Pole tekstowe na dole - nad BottomNavigationBar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border(
                top: BorderSide(color: borderColor, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Write your question...',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    ),
                    onChanged: (value) {
                      setState(() {}); // Odśwież UI gdy użytkownik pisze
                    },
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: _askAi,
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16, 
                      color: Color.fromARGB(255, 28, 133, 33),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// ...existing code...