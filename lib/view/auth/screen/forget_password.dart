import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:study_over_flow/core/const/app_color.dart';
import 'package:study_over_flow/view/auth/screen/login_screen.dart';

import '../../../core/widget/customer_button.dart';
import '../../../core/widget/customer_or_widget.dart';
import '../../../core/widget/customer_toast.dart';
import '../../../core/widget/text_form.dart';
import '../widget/login_bot_nav.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  static const routeName = "/forget_password_screen";

  @override
  State<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController =
      TextEditingController();

  final GlobalKey<FormState> _email = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _restPassword() async {
    final email = _emailController.text.trim();

    if (!_email.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final url = Uri.parse('https://example.com/api/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        customerFlutterToast(
            "Reset password link sent to your successful",
            primaryColor);
      } else {
        final errorData = jsonDecode(response.body);
        setState(() {
          _errorMessage =
              errorData['message'] ?? 'Invalid credentials';
          customerFlutterToast(_errorMessage!);
        });
      }
    } catch (e) {
      setState(() {
        customerFlutterToast(
            "An error occurred while Reset Password in. Please try again later.");
      });
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:backgroundColorLight,
      bottomNavigationBar:  LoginBottNaveBare(
        title: 'Have an account already?',
        subTitle: 'LogIn',
        onPressed: () {
          Navigator.pushReplacementNamed(context, LogInScreen.routeName);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Center(
                child: Image.asset(
                  "assets/images/image2.png",
                  height: 300,
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Reset Password",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 27,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomerTextForm(
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                  message: 'Email can\'t be empty',
                  formKey: _email,
                  icon: const Icon(Icons.email),
                  hintText: 'Email:',
                  onFieldSubmitted: (value) {},
                  onEditingComplete: () {
                    _restPassword();
                  }),
              const SizedBox(height: 12),
              if (_isLoading)
                const Center(
                    child: CircularProgressIndicator(
                  color: primaryColor,
                ))
              else
                CustomerButton(
                  title: 'Rest Password',
                  onPressed: _restPassword,
                ),
              const CustomerOrWidget(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
