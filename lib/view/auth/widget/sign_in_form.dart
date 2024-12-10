import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

import '../../splash/screen/splash_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool obscureText = true;
  bool isLoading = false;

  // Using nullable types, no need for `late`
  SMITrigger? error;
  SMITrigger? success;
  SMITrigger? reset;
  SMITrigger? confetti;

  void _onCheckRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'State Machine 1');
    if (controller == null) {
      debugPrint("Failed to load state machine controller for check animation.");
      return;
    }
    artboard.addController(controller);

    error = controller.findInput<bool>('Error') as SMITrigger?;
    success = controller.findInput<bool>('Check') as SMITrigger?;
    reset = controller.findInput<bool>('Reset') as SMITrigger?;

    if (error == null || success == null || reset == null) {
      debugPrint("Error: Missing triggers in the state machine.");
    }
  }

  void _onConfettiRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'State Machine 1');
    if (controller == null) {
      debugPrint("Failed to load state machine controller for confetti.");
      return;
    }
    artboard.addController(controller);

    confetti = controller.findInput<bool>('Trigger explosion') as SMITrigger?;
    if (confetti == null) {
      debugPrint("Error: Missing 'Trigger explosion' trigger in confetti state machine.");
    }
  }

  void togglePassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Future<void> signIn() async {
    if (!_formKey.currentState!.validate()) {
      // Check if the error trigger is initialized before calling it
      error?.fire(); // Safe to call
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Simulate a sign-in process
    await Future.delayed(const Duration(seconds: 2));
    final bool isAuthenticated = emailController.text == "test" && passwordController.text == "test";

    setState(() {
      isLoading = false;
    });

    if (isAuthenticated) {
      success?.fire(); // Safe to call
      Future.delayed(const Duration(seconds: 1), () {
        confetti?.fire(); // Safe to call
        if(mounted) {
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      });
    } else {
      error?.fire(); // Safe to call
      Future.delayed(const Duration(seconds: 2), () {
        reset?.fire(); // Safe to call
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Name", style: TextStyle(color: Colors.black54)),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (string)=> signIn(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset("assets/icons/email.svg"),
                    ),
                  ),
                ),
              ),
              const Text("Email", style: TextStyle(color: Colors.black54)),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (string)=> signIn(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset("assets/icons/email.svg"),
                    ),
                  ),
                ),
              ),
              const Text("Password", style: TextStyle(color: Colors.black54)),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: obscureText,
                  onFieldSubmitted: (string)=> signIn(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: togglePassword,
                        child: SvgPicture.asset("assets/icons/password.svg"),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                child: ElevatedButton.icon(
                  onPressed: signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF77D8E),
                    minimumSize: const Size(double.infinity, 56),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  icon: const Icon(CupertinoIcons.arrow_right, color: Color(0xFFFE0037)),
                  label: const Text("Sign In"),
                ),
              ),
            ],
          ),
        ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}

