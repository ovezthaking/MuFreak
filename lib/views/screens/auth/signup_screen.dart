import 'package:flutter/material.dart';
import 'package:mufreak/constants.dart';
import 'package:mufreak/views/widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

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
              'Register', 
              style: TextStyle(
                fontSize: 25, 
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 15,
              ),
              Stack(
              children: [
                Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: borderColor,
                      width: 4.0,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 64,
                    backgroundImage: AssetImage(DefaultProfileImage.png),
                    backgroundColor: Colors.black,
                  ),
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () {
                      print("pick a photo");
                    },
                    icon: const Icon(Icons.add_a_photo),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
              ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _usernameController,
                labelText: 'Username',
                isObscure: false,
                icon: Icons.person,
              ),
            ),
            const SizedBox(
              height: 15,
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
              height: 15,
              ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                labelText: 'Password',
                isObscure: false,
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
                onTap: () {
                  print('Register user');
                },
                child: const Center(
                  child: Text(
                    'Register', 
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
                const Text("Do u have an account?", style: TextStyle(fontSize: 20,),),
                InkWell(
                  onTap: () {
                    print('navigating user');
                  },
                  child: 
                Text(' Log in', style: TextStyle(fontSize: 20, color: buttonColor),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}