import 'package:flutter/material.dart';

class CustomerButton extends StatelessWidget {
  const CustomerButton({
    super.key, this.onPressed, 
    required this.title});

  final void Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 25),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(title,
                    style: TextStyle(
                      wordSpacing: 1,
                      color: Colors.grey[800],
                      fontFamily: "intel",
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    )),
              ))),
        ));
  }
}
