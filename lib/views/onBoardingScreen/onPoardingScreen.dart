import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/components/components.dart';
import 'package:twitter/components/constants.dart';
import 'package:twitter/views/loginScreen/loginScreen.dart';
import 'package:twitter/views/registerScreen/registerScreen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mainBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 250.0,
              ),

              // The Row of Twitter icon and Twitter text
              Row(
                children: const [
                  SizedBox(
                    width: 70.0,
                  ),
                  Icon(
                    FontAwesomeIcons.twitter,
                    color: mainWhiteColor,
                    size: 50,
                  ),
                  Text(
                    'Twitter',
                    style: TextStyle(
                      color: mainWhiteColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // The Text under the Twitter icon Row
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'See what\'s \n happening in the \n world right now',
                  style: TextStyle(
                    color: mainWhiteColor,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 60.0,
              ),

              // Login Row of Twitter
              buildLoginTwitter(
                  onPress: () {
                    navigateTo(context, const LoginScreen());
                  },
                  text: 'Login to Twitter      ',
                  backgroundColor: mainWhiteColor,
                  arrowColor: mainDeepBlueColor),

              // Create a new Account Row
              buildLoginTwitter(
                  onPress: () {
                    navigateTo(context, const RegisterScreen());
                  },
                  text: 'Create new account',
                  backgroundColor: mainWhiteColor.withOpacity(0.16),
                  arrowColor: mainWhiteColor),
            ],
          ),
        ),
      ),
    );
  }
}
