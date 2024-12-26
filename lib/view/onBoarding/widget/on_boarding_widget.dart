import 'package:flutter/material.dart';
import 'package:study_over_flow/core/utils/helper_class/size_config.dart';

import '../../../core/const/app_color.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.desc});

  final String image;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH! ;
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Expanded(
            // Wrap the Image.asset with Expanded
            child: Image.asset(
              image,
              // Remove fixed height here, let it be flexible
            ),
          ),
          SizedBox(
            height: (height >= 840) ? 60 : 30,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: primaryColorShade600,
              fontFamily: "Mulish",
              fontWeight: FontWeight.w600,
              fontSize: (width <= 550) ? 30 : 35,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            desc,
            style: TextStyle(
              fontFamily: "Mulish",
              fontWeight: FontWeight.w300,
              fontSize: (width <= 550) ? 17 : 25,
              color: shadowColorDark,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
