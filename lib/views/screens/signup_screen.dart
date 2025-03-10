import 'package:flutter/material.dart';
import 'package:tiktok/views/screens/login_screen.dart';

import '../../constants.dart';
import '../widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _usernameController = TextEditingController();
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
              'Tiktok Clone',
              style: TextStyle(
                  fontSize: 35,
                  color: buttonColor,
                  fontWeight: FontWeight.w900),
            ),
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 25,
            ),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSc1r3PxoZ-GnkkHkgOZ0aYVMxaxNDTk0GxJw&s"),
                  backgroundColor: Colors.black,
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                      onPressed: () => authController.pickImage(),
                       icon: const Icon(Icons.add_a_photo)),)
              ],
            ),
            SizedBox(height: 25,),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                  controller: _usernameController,
                  labelText: 'Username',
                  icon: Icons.person),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                  controller: _emailController,
                  labelText: 'Email',
                  icon: Icons.email),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                  controller: _passwordController,
                  labelText: 'password',
                  isObscure: true,
                  icon: Icons.lock),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 40,
              height: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: InkWell(
                  onTap: () =>
                      authController.registerUser(
                          _usernameController.text.trim(),
                          _emailController.text.trim(),
                          _passwordController.text.trim(), authController.profilePhoto),
                  child: Center(
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ))),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ', style: TextStyle(fontSize: 20),),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20, color: buttonColor),
                  ),
                ),
              ],
            )
          ],
        )
        ,
      )
      ,
    );
  }
}
