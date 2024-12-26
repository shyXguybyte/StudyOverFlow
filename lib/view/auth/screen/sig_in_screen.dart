import 'package:flutter/material.dart';
import 'package:study_over_flow/core/widget/customer_or_widget.dart';
import 'package:study_over_flow/model/remote/sigin_model.dart';
import 'package:study_over_flow/view/auth/screen/login_screen.dart';

import '../../../core/class/curd.dart';
import '../../../core/class/request_state.dart';
import '../../../core/const/app_color.dart';
import '../../../core/utils/helper_functions/handel_request.dart';
import '../../../core/widget/customer_button.dart';
import '../../../core/widget/customer_toast.dart';
import '../../../core/widget/text_form.dart';
import '../../../model/local/auth/register_model.dart';
import '../widget/login_bot_nav.dart';

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
    RegisterModel registerModel = RegisterModel(
      firstName: _firstNameController.text.trim(),
      lastName: _lastnameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      userName: _usernameController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await sigInData.sigIn(
        firstName: registerModel.firstName,
        lastName: registerModel.lastName,
        userName: registerModel.userName,
        email: registerModel.email,
        password: registerModel.password,
        phone: registerModel.phone,
      );

      final state = handleRequest(result);
      if (state == RequestState.loaded) {
        // Success logic
        customerFlutterToast("Sign in successful", green);
        if (mounted) {
          Navigator.pushReplacementNamed(
              context, LogInScreen.routeName);
        }
      } else if (state == RequestState.internetFailure) {
        customerFlutterToast("No internet connection", red);
      } else if (state == RequestState.emailAlreadyExist) {
        customerFlutterToast(
            "Email or User name are used. Please try again",
            red);
      } else {
        customerFlutterToast("Sign in failed: $state", red);
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred. Please try again later.";
      });
      customerFlutterToast(_errorMessage!, red);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: LoginBottNaveBare(
        title: "Already have an account?",
        subTitle: "Login",
        onPressed: () {
          Navigator.pushReplacementNamed(
              context, LogInScreen.routeName);
        },
      ),
      backgroundColor: backgroundColorLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Create an Account",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Please enter your details ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    wordSpacing: .2,
                    color: Colors.grey[600],
                    fontFamily: "intel",
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CustomerTextForm(
                controller: _firstNameController,
                message: 'Name Can\'t Be Empty',
                formKey: _firstName,
                icon: Icon(Icons.person),
                hintText: 'First Name:',
                onFieldSubmitted: (value) {
                  _signIn();
                },
                onEditingComplete: _signIn,
              ),
              const SizedBox(height: 20),
              CustomerTextForm(
                controller: _lastnameController,
                message: 'Name Can\'t Be Empty',
                formKey: _lastname,
                icon: Icon(Icons.person),
                hintText: 'Last Name:',
                onFieldSubmitted: (value) {
                  _signIn();
                },
                onEditingComplete: _signIn,
              ),
              const SizedBox(height: 20),
              CustomerTextForm(
                controller: _usernameController,
                message: 'User Name Can\'t Be Empty',
                formKey: _username,
                icon: Icon(Icons.supervised_user_circle_rounded),
                hintText: 'User Name:',
                onFieldSubmitted: (value) {
                  _signIn();
                },
                onEditingComplete: _signIn,
              ),
              const SizedBox(height: 20),
              CustomerTextForm(
                isEmail: true,
                controller: _emailController,
                message: 'Email Can\'t Be Empty',
                formKey: _email,
                icon: Icon(Icons.email),
                hintText: 'Email:',
                onFieldSubmitted: (value) {
                  _signIn();
                },
                onEditingComplete: _signIn,
              ),
              const SizedBox(height: 20),
              CustomerTextForm(
                controller: _passwordController,
                message: 'Password Can\'t Be Empty',
                formKey: _password,
                icon: InkWell(
                  onTap: _togglePasswordVisibility,
                  child: _isObscure
                      ? Icon(Icons.lock)
                      : Icon(Icons.lock_open),
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
              CustomerOrWidget(),
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
