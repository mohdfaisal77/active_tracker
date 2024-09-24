import 'package:flutter/material.dart';
import 'package:test_project_login/utils/app_strings.dart';

import 'main_screen.dart';

class LoginScreen extends StatelessWidget {

  LoginScreen({super.key});

  final TextEditingController userNameController =TextEditingController();
  final TextEditingController passwordController =TextEditingController();
  final String dummyUserName = AppStrings.user;
  final String dummyPassword = "password";

  void _login(BuildContext context){
    if(userNameController.text== dummyUserName &&
    passwordController.text == dummyPassword
    ){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainScreen(userName:dummyUserName)));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid User Credentials")));
    }
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.login_screen),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: userNameController,
              decoration: InputDecoration(labelText: AppStrings.userName),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText:AppStrings.password),
              obscureText: true,
            ),
            SizedBox(height: height  * 0.05),
            ElevatedButton(

                onPressed: ()=>
              _login(context),
             child: Text(AppStrings.login))
          ],
        ),
      ),
    );
  }
}
