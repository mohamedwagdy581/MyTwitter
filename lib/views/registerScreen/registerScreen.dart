import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twitter/components/components.dart';
import 'package:twitter/shared/local/sharedPreferences.dart';
import 'package:twitter/views/homePage/homePage.dart';
import 'package:twitter/views/loginScreen/loginScreen.dart';

import '../../components/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  bool isPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _userNameController.dispose();
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
                height: height * 0.2,
              ),
              Container(
                height: height * 0.65,
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
                          'Create your Account, Now!',
                          style: TextStyle(
                            color: mainBlackColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 50.0,
                        ),

                        // Name TextField
                        defaultTextField(
                          onTap: () {},
                          controller: _nameController,
                          onSubmit: (value) {
                            if (_formKey.currentState!.validate()) {}
                            return null;
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter invalid name';
                            }
                            return null;
                          },
                          prefix: Icons.person,
                          label: 'Name',
                        ),

                        const SizedBox(
                          height: 20.0,
                        ),

                        // User Name TextField
                        defaultTextField(
                          onTap: () {},
                          controller: _userNameController,
                          onSubmit: (value) {
                            if (_formKey.currentState!.validate()) {}
                            return null;
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'This user name already exist';
                            }
                            return null;
                          },
                          prefix: Icons.perm_identity,
                          label: 'User Name',
                        ),

                        const SizedBox(
                          height: 20.0,
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
                          label: 'Email',
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
                          label: 'Password',
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
                          height: 18.0,
                        ),

                        // Login Button
                        defaultButton(
                          onPressed: () async {
                            //
                            _apiAccountRegister();
                          },
                          title: 'Register',
                        ),

                        const SizedBox(
                          height: 10.0,
                        ),

                        // Register Row
                        buildRegisterRow(
                          onPress: () {
                            navigateAndFinish(context, const LoginScreen());
                          },
                          text: 'Have an account?',
                          btnText: 'Login Now!',
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

  Future _apiAccountRegister() async {
    var url = Uri.parse(REGISTER_URL);

    var responce = await http.post(url, body: {
      "email": _emailController.text,
      "userName": _userNameController.text,
      "password": _passwordController.text,
    });
    if (responce.statusCode == 200) {
      var body = jsonDecode(responce.body.toString());
      print('Account Created' + body);

      // Save token in Shared Preferences
      SharedPrefs.setToken(body['jwt']);

      navigateAndFinish(context, const HomePage());
    } else {
      var body = jsonDecode(responce.body.toString());
      print(body['messages']['message']);
    }
  }
}
