import 'package:flutter/material.dart';

import 'constants.dart';

// Build GradientBackground
Widget mainBackground({
  Widget? child,
}) =>
    Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.03, 0.1, 0.68, 0.8, 0.88, 0.99],
          colors: [
            mainLightBlueColor,
            mainDeepBlueColor,
            Colors.blue,
            mainLightBlueColor,
            Colors.blueAccent,
            mainDeepBlueColor,
          ],
        ),
      ),
      child: child,
    );

// Build Login and Register TextButton
Widget buildLoginTwitter({
  required VoidCallback onPress,
  required String text,
  required Color backgroundColor,
  required Color arrowColor,
}) =>
    TextButton(
      onPressed: onPress,
      style: TextButton.styleFrom(
        primary: Colors.transparent,
        elevation: 0.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: mainWhiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: arrowColor,
              ),
            ),
          ),
        ],
      ),
    );

// Default TextFormField
Widget defaultTextField({
  required IconData prefix,
  IconData? suffix,
  required String label,
  required Function() onTap,
  String? Function(String?)? validate,
  String? Function(String?)? onSubmit,
  String? Function(String?)? onChange,
  VoidCallback? isSuffix,
  bool isPassword = false,
  TextEditingController? controller,
  TextInputType? keyboardType,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      validator: validate,
      keyboardType: keyboardType,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
      onChanged: onChange,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: isSuffix,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );

// Default Button
Widget defaultButton({
  required VoidCallback onPressed,
  required String title,
  Color buttonColor = mainDeepBlueColor,
  Color textColor = Colors.white,
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    ),
  );
}

// Forget Password or Register

Widget buildRegisterRow({
  required String text,
  required String btnText,
  required VoidCallback onPress,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 14.0,
            color: mainBlackColor,
          ),
        ),
        TextButton(
          onPressed: onPress,
          child: Text(
            btnText,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: mainDeepBlueColor,
            ),
          ),
        ),
      ],
    );

// Navigate To
void navigateTo(
  context,
  widget,
) =>
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

// Navigate and Remove the priviest page

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );
