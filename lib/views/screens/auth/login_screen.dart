import 'package:flutter/material.dart';
import 'package:mufreak/constants.dart';
import 'package:mufreak/views/screens/auth/signup_screen.dart';
import 'package:mufreak/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'MuFreak',
              style: TextStyle(
                fontSize: 35, 
                color: buttonColor, 
                fontWeight: FontWeight.w900,
                ),
            ),
            const Text(
              'Login', 
              style: TextStyle(
                fontSize: 25, 
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 25,
              ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _emailController,
                labelText: 'Email',
                isObscure: false,
                icon: Icons.email,
              ),
            ),
            const SizedBox(
              height: 25,
              ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                labelText: 'Password',
                isObscure: true,
                icon: Icons.lock,
              ),
            ),
            const SizedBox(
              height: 25,
              ),
            Container(
              width: MediaQuery.of(context).size.width-40,
              height: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: InkWell(
                onTap: () => authController.loginUser(
                    _emailController.text, 
                    _passwordController.text,
                ),
                child: const Center(
                  child: Text(
                    'Login', 
                    style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Have u not registered yet?", style: TextStyle(fontSize: 20,),),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: 
                Text(' Register', style: TextStyle(fontSize: 20, color: buttonColor),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}