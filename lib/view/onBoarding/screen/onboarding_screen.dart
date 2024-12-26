import 'package:flutter/material.dart';
import 'package:study_over_flow/core/utils/helper_class/size_config.dart';
import '../../../core/const/app_color.dart';
import '../../../core/utils/helper_class/shared_pref_hellper.dart';
import '../../../core/widget/customer_button.dart';
import '../../../model/local/on_boarding/onboarding_contents.dart';
import '../../auth/screen/login_screen.dart';
import '../widget/on_boarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const routeName = '/onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;
  List colors = const [
    elevatedButtonColor,
    elevatedButtonColor,
    elevatedButtonColor,
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) =>
      AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          color: shadowColorDark,
        ),
        margin: const EdgeInsets.only(right: 5),
        height: 10,
        curve: Curves.easeIn,
        width: _currentPage == index ? 20 : 10,
      );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) =>
                    setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return OnBoardingWidget(
                    image: contents[i].image,
                    title: contents[i].title,
                    desc: contents[i].desc,
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                      (int index) => _buildDots(
                        index: index,
                      ),
                    ),
                  ),
                  _currentPage + 1 == contents.length
                      ? CustomerButton(
                          title: 'Lets Go',
                          onPressed: () async {
                            await SharedPreferencesHelper.setBool(key: "onBoarding", value: true);
                            if(mounted) {
                              Navigator.pushReplacementNamed(
                                context, LogInScreen.routeName);
                            }
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _controller.jumpToPage(2);
                                },
                                style: TextButton.styleFrom(
                                  elevation: 0,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        (width <= 550) ? 13 : 17,
                                  ),
                                ),
                                child: const Text(
                                  "SKIP",
                                  style:
                                      TextStyle(color: shadowColorDark),
                                ),
                              ),
                              FloatingActionButton(
                                heroTag: "next",
                                backgroundColor: shadowColorDark,
                                onPressed: () {
                                  _controller.nextPage(
                                    duration: const Duration(
                                        milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: backgroundColorLight,
                                ),
                              )
                            ],
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
