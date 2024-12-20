import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:study_over_flow/view/auth/screen/login_screen.dart';

import '../../../core/widget/customer_button.dart';
import '../../../core/widget/customer_or_widget.dart';
import '../../../core/widget/customer_toast.dart';
import '../../../core/widget/text_form.dart';
import '../widget/login_bot_nav.dart';

class RestPasswordScreen extends StatefulWidget {
  const RestPasswordScreen({super.key});

  static const routeName = "/rest_password_screen";

  @override
  State<RestPasswordScreen> createState() =>
      _RestPasswordScreenState();
}

class _RestPasswordScreenState extends State<RestPasswordScreen> {
  final TextEditingController _passwordController =
      TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _passwordFormKey =
      GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmPasswordFormKey =
      GlobalKey<FormState>();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _restPassword() async {
    final email = _passwordController.text.trim();

    if (_passwordFormKey.currentState!.validate() &&
        _confirmPasswordFormKey.currentState!.validate()) {
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
            Colors.amber);
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
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/image3.png",
                  height: 300,
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Update Password",
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
                  textInputType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  message: 'Password can\'t be empty',
                  formKey: _passwordFormKey,
                  icon: const Icon(Icons.email),
                  hintText: 'Password:',
                  onFieldSubmitted: (value) {},
                  onEditingComplete: () {
                    _restPassword();
                  }),
              const SizedBox(height: 20),
              CustomerTextForm(
                  textInputType: TextInputType.visiblePassword,
                  controller: _confirmPasswordController,
                  message: 'Confirm Password can\'t be empty',
                  formKey: _confirmPasswordFormKey,
                  icon: const Icon(Icons.email),
                  hintText: 'Confirm Password:',
                  onFieldSubmitted: (value) {},
                  onEditingComplete: () {
                    _restPassword();
                  }),
              const SizedBox(height: 12),
              if (_isLoading)
                const Center(
                    child: CircularProgressIndicator(
                  color: Colors.amber,
                ))
              else
                CustomerButton(
                  title: 'Update Password',
                  onPressed: _restPassword,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
