import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:study_over_flow/model/remote/sigin_model.dart';
import 'package:study_over_flow/view/auth/screen/login_screen.dart';

import '../../../core/class/curd.dart';
import '../../../core/class/request_state.dart';
import '../../../core/utils/helper_functions/handel_request.dart';
import '../../../core/widget/customer_button.dart';
import '../../../core/widget/customer_toast.dart';
import '../../../core/widget/text_form.dart';
import 'confirm_screen.dart';

class SigInScreen extends StatefulWidget {
  const SigInScreen({super.key});

  static const routeName = "/sig_in_screen";

  @override
  State<SigInScreen> createState() => _SigInScreenState();
}

class _SigInScreenState extends State<SigInScreen> {
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();
  final TextEditingController _firstNameController =
      TextEditingController();
  final TextEditingController _lastnameController =
      TextEditingController();
  final TextEditingController _phoneController =
      TextEditingController();
  final TextEditingController _usernameController =
      TextEditingController();

  final GlobalKey<FormState> _email = GlobalKey<FormState>();
  final GlobalKey<FormState> _password = GlobalKey<FormState>();
  final GlobalKey<FormState> _firstName = GlobalKey<FormState>();
  final GlobalKey<FormState> _lastname = GlobalKey<FormState>();
  final GlobalKey<FormState> _phone = GlobalKey<FormState>();
  final GlobalKey<FormState> _username = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isObscure = true;
  String? _errorMessage;

  final SigInRemoteData sigInData = SigInRemoteData(Curd());

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Future<void> _signIn() async {
    if (!_firstName.currentState!.validate() ||
        !_lastname.currentState!.validate() ||
        !_email.currentState!.validate() ||
        !_password.currentState!.validate() ||
        !_phone.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await sigInData.sigIn(
        firstName: _firstNameController.text.trim(),
        lastName: _lastnameController.text.trim(),
        userName: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        phone: _phoneController.text.trim(),
      );

      final state = handleRequest(result);
      print(state);
      if (state == RequestState.loaded) {
        // Success logic
        customerFlutterToast("Sign in successful", Colors.green);
        if(mounted){
          Navigator.pushReplacementNamed(context,LogInScreen.routeName);
        }
      } else if (state == RequestState.internetFailure) {
        customerFlutterToast("No internet connection", Colors.red);
      } else if (state == RequestState.emailAlreadyExist) {
        customerFlutterToast(
            "Email or User name are used. Please try again", Colors.red);
      } else {
        customerFlutterToast("Sign in failed: $state", Colors.red);
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred. Please try again later.";
      });
      customerFlutterToast(_errorMessage!, Colors.red);
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
              const SizedBox(height: 15),
              Center(
                child: Image.asset(
                  "assets/images/image1.png",
                  height: 180,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Sign In",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomerTextForm(
                controller: _firstNameController,
                message: 'Name Can\'t Be Empty',
                formKey: _firstName,
                icon: Icon(Icons.person),
                hintText: 'First Name:',
                onFieldSubmitted: (value) {},
              ),
              const SizedBox(height: 20),
              CustomerTextForm(
                controller: _lastnameController,
                message: 'Name Can\'t Be Empty',
                formKey: _lastname,
                icon: Icon(Icons.person),
                hintText: 'Last Name:',
                onFieldSubmitted: (value) {},
              ),
              const SizedBox(height: 20),
              CustomerTextForm(
                controller: _usernameController,
                message: 'User Name Can\'t Be Empty',
                formKey: _username,
                icon: Icon(Icons.person),
                hintText: 'User Name:',
                onFieldSubmitted: (value) {
                  _signIn();
                },
              ),
              const SizedBox(height: 20),
              CustomerTextForm(
                controller: _emailController,
                message: 'Email Can\'t Be Empty',
                formKey: _email,
                icon: Icon(Icons.email),
                hintText: 'Email:',
                onFieldSubmitted: (value) {
                  _signIn();
                },
              ),
              const SizedBox(height: 20),
              CustomerTextForm(
                controller: _passwordController,
                message: 'Password Can\'t Be Empty',
                formKey: _password,
                icon: InkWell(
                  onTap: _togglePasswordVisibility,
                  child: _isObscure ? Icon(Icons.lock):Icon(Icons.lock_open),
                ),
                hintText: 'Password:',
                obscureText: _isObscure,
                onFieldSubmitted: (value) {
                  _signIn();
                },
              ),
              const SizedBox(height: 20),
              CustomerTextForm(
                controller: _phoneController,
                message: 'Phone Can\'t Be Empty',
                formKey: _phone,
                icon: Icon(Icons.phone),
                hintText: 'Phone:',
                obscureText: false,
                textInputType: TextInputType.phone,
                onFieldSubmitted: (value) {
                  _signIn();
                },
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : CustomerButton(
                      title: 'Sign In',
                      onPressed: _signIn,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }
}
