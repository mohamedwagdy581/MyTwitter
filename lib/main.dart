import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter/views/homePage/homePage.dart';
import 'package:twitter/views/onBoardingScreen/onPoardingScreen.dart';

SharedPreferences? preferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  String? token = preferences?.getString('token');

  Widget _screen;

  if (token == null || token == '') {
    _screen = const OnBoardingScreen();
  } else {
    _screen = const HomePage();
  }
  runApp(MyApp(
    screen: _screen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget screen;
  const MyApp({Key? key, required this.screen}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: screen,
    );
  }
}
