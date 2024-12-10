import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' hide Image;
import 'package:study_over_flow/core/const/app_text.dart';
import 'package:study_over_flow/view/auth/screen/login_screen.dart';

import '../../../core/const/app_image.dart';
import '../../../core/styles/app_styles.dart';
import '../widget/animated_btn.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  
  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: width * 1.7,
            left: 120,
            bottom: 120,
            child: Image.asset(
              backgroundImage,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset(
            riverAsset,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isShowSignInDialog ? -50 : 0,
            height: height,
            width: width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 260,
                      child: Column(
                        children: [
                          Text(
                            splashTitle,
                            style: AppStyles.semiBoldTextStyle55
                          ),
                          const SizedBox(height: 16),
                          const Text(splashSubTitle),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;

                        Future.delayed(
                          const Duration(milliseconds: 800),
                          () {
                            setState(() {
                              isShowSignInDialog = true;
                            });
                            if (!context.mounted) return;
                            showCustomDialogLogin(
                              context,
                              onValue: (_) {},
                            );
                           },
                        );
                      },
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          splashContentTitle,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
