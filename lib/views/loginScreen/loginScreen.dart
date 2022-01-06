import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twitter/components/components.dart';
import 'package:twitter/components/constants.dart';
import 'package:twitter/views/registerScreen/registerScreen.dart';

import '../homePage/homePage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return mainBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.26,
              ),
              Container(
                height: height * 0.53,
                width: width * 0.88,
                decoration: const BoxDecoration(
                  color: mainWhiteColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          'Login to your Account, Now!',
                          style: TextStyle(
                            color: mainBlackColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 50.0,
                        ),

                        // Email TextField
                        defaultTextField(
                          onTap: () {},
                          controller: _emailController,
                          onSubmit: (value) {
                            if (_formKey.currentState!.validate()) {}
                            return null;
                          },
                          validate: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter invalid email';
                            }
                            return null;
                          },
                          prefix: Icons.email,
                          label: 'Enter your Email',
                        ),

                        const SizedBox(
                          height: 20.0,
                        ),

                        // Password TextField
                        defaultTextField(
                          onTap: () {},
                          onSubmit: (value) {
                            if (_formKey.currentState!.validate()) {}
                            return null;
                          },
                          controller: _passwordController,
                          validate: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'Password must be at least 8 letters or numbers';
                            }
                            return null;
                          },
                          isPassword: isPassword,
                          keyboardType: TextInputType.visiblePassword,
                          prefix: Icons.lock,
                          label: 'Enter your Password',
                          suffix: isPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          //isPassword ? Icons.visibility_off : suffix,
                          isSuffix: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                        ),

                        const SizedBox(
                          height: 10.0,
                        ),

                        // Forget Password
                        buildRegisterRow(
                          onPress: () {},
                          text: 'Forget Password?',
                          btnText: 'Reset Now!',
                        ),

                        const SizedBox(
                          height: 10.0,
                        ),

                        // Login Button
                        defaultButton(
                          onPressed: () {
                            _apiAccountLogin();
                          },
                          title: 'Login',
                        ),

                        const SizedBox(
                          height: 10.0,
                        ),

                        // Register Row
                        buildRegisterRow(
                          onPress: () {
                            navigateAndFinish(context, const RegisterScreen());
                          },
                          text: 'Don\'t Have an account?',
                          btnText: 'Register',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _apiAccountLogin() async {
    var url = Uri.parse(LOGIN_URL);

    var responce = await http.post(url, body: {
      "identifier": _emailController.text,
      "password": _passwordController.text,
    });
    if (responce.statusCode == 200) {
      var body = jsonDecode(responce.body.toString());
      print('Account Login' + body.toString());
      navigateAndFinish(context, const HomePage());
    } else {
      var body = jsonDecode(responce.body.toString());
      print('Can not login to your Account');
      print(body['messages']['message']);
    }
  }
}
