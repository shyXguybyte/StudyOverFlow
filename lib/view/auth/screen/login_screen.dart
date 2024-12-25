import 'package:flutter/material.dart';
import 'package:study_over_flow/view/auth/screen/sig_in_screen.dart';
import '../../../core/class/curd.dart';
import '../../../core/class/request_state.dart';
import '../../../core/utils/helper_functions/handel_request.dart';
import '../../../core/widget/customer_button.dart';
import '../../../core/widget/customer_or_widget.dart';
import '../../../core/widget/customer_toast.dart';
import '../../../core/widget/text_form.dart';
import '../../../model/local/auth/login_model.dart';
import '../../../model/remote/login_,model.dart';
import '../widget/login_bot_nav.dart';
import 'forget_password.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  static const routeName = "/log_in_screen";

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey =
      GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isObscure = true;
  String? _errorMessage;

  final LoginRemoteData loginData = LoginRemoteData(Curd());

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Future<void> _logIn() async {
    if (!_isLoading) {
      {
        if (!_emailFormKey.currentState!.validate() ||
            !_passwordFormKey.currentState!.validate()) {
          return;
        }
        
        final LoginModel loginModel = LoginModel(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

        setState(() {
          _isLoading = true;
          _errorMessage = null;
        });

        try {
          final result = await loginData.login(
            userName: loginModel.email,
            password:loginModel.password,
          );

          final state = handleRequest(result);
          if (state == RequestState.loaded) {
            customerFlutterToast("Login successful", Colors.green);
            // Navigate to Home Screen or Dashboard Screen page
            if(mounted){
              Navigator.pushReplacementNamed(context, "/dashboard");
            } 
            // Example
          } else if (state == RequestState.internetFailure) {
            customerFlutterToast("No internet connection", Colors.red);
          } else if (state == RequestState.unauthorised) {
            customerFlutterToast("Invalid User Name or Password", Colors.red);
          } else {
            customerFlutterToast("Login failed: $state", Colors.red);
          }
        } catch (e) {
          setState(() {
            _errorMessage =
                "An error occurred. Please try again later.";
          });
          customerFlutterToast(_errorMessage!, Colors.red);
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      bottomNavigationBar: LoginBottNaveBare(
        title: "Don't Have Account?",
        subTitle: "Sign In",
        onPressed: () {
          Navigator.pushReplacementNamed(
              context, SigInScreen.routeName);
        },
      ),
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
                  "Log In",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomerTextForm(
                isEmail: true,
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
                message: 'Email can\'t be empty',
                icon: const Icon(Icons.email),
                hintText: 'Email:',
                formKey: _emailFormKey,
                onFieldSubmitted: (_) {
                  _logIn();
                },
                onEditingComplete: _logIn,
              ),
              const SizedBox(height: 30),
              CustomerTextForm(
                textInputType: TextInputType.visiblePassword,
                controller: _passwordController,
                message: 'Password can\'t be empty',
                icon: InkWell(
                  onTap: _togglePasswordVisibility,
                  child: _isObscure
                      ? Icon(Icons.lock)
                      : Icon(Icons.lock_open),
                ),
                hintText: 'Password:',
                obscureText: _isObscure,
                formKey: _passwordFormKey,
                onFieldSubmitted: (_) {
                  _logIn();
                },
                onEditingComplete: _logIn,
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                     Text(
                      "Forget Password? ",
                      style: TextStyle(
                        fontFamily: "intel",
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, ForgetPasswordScreen.routeName);
                      },
                      child: const Text(
                        "Reset",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: "intel",
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(
                        color: Colors.amber),
                  ),
                )
              else
                CustomerButton(
                  title: 'Log In',
                  onPressed: _logIn,
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
    _passwordController.dispose();
    super.dispose();
  }
}
