import 'package:flutter/material.dart';
import 'package:study_over_flow/view/auth/screen/sig_in_screen.dart';

class LoginBottNaveBare extends StatelessWidget {
  const LoginBottNaveBare(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String title;

  final String subTitle;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: "intel",
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              subTitle,
              style: TextStyle(
                  color: Colors.amber,
                  fontFamily: "intel",
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black26,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
