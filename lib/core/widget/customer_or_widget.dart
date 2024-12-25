import 'package:flutter/material.dart';



class CustomerOrWidget extends StatelessWidget {
  const CustomerOrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
          vertical: 10, horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Divider(color: Colors.black26)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.0),
            child: Text(
              "OR",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black45,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.black26)),
        ],
      ),
    );
  }
}
