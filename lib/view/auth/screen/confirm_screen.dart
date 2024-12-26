import 'package:flutter/material.dart';
import 'package:study_over_flow/view/auth/screen/login_screen.dart';
import 'package:study_over_flow/view/auth/screen/sig_in_screen.dart';

import '../../../core/class/curd.dart';
import '../../../core/class/request_state.dart';
import '../../../core/const/app_color.dart';
import '../../../core/utils/helper_functions/handel_request.dart';
import '../../../core/widget/customer_button.dart';
import '../../../core/widget/customer_or_widget.dart';
import '../../../core/widget/customer_toast.dart';
import '../../../core/widget/text_form.dart';
import '../../../model/remote/re_confirm_model.dart';
import '../widget/login_bot_nav.dart';

class ConfirmEmailScreen extends StatefulWidget {
  const ConfirmEmailScreen({super.key});

  static const routeName = "/confirm_screen_screen";

  @override
  State<ConfirmEmailScreen> createState() =>
      _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  final TextEditingController _emailController =
      TextEditingController();

  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _errorMessage;

  final ReConfirmData reConfirmData = ReConfirmData(Curd());

  Future<void> _confirmEmail() async {
    if (!_isLoading) {
      {
        if (!_emailFormKey.currentState!.validate()) {
          return;
        }

        setState(() {
          _isLoading = true;
          _errorMessage = null;
        });

        try {
          final result = await reConfirmData.login(
              email: _emailController.text.trim());

          final state = handleRequest(result);
          if (state == RequestState.loaded) {
            customerFlutterToast("Confirmation email seated ", green);
            // Navigate to Home Screen or Dashboard Screen page
            if (mounted) {
              Navigator.pushReplacementNamed(
                  context, LogInScreen.routeName);
            }
            // Example
          } else if (state == RequestState.internetFailure) {
            customerFlutterToast("No internet connection", red);
          } else if (state == RequestState.unauthorised) {
            customerFlutterToast("Invalid User email ", red);
          } else {
            customerFlutterToast("ReConfirm email failed: $state", red);
          }
        } catch (e) {
          setState(() {
            _errorMessage =
                "An error occurred. Please try again later.";
          });
          customerFlutterToast(_errorMessage!, red);
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
      bottomNavigationBar: LoginBottNaveBare(
        title: "Don't Have Account?",
        subTitle: "Sign In",
        onPressed: () {
          Navigator.pushReplacementNamed(
              context, SigInScreen.routeName);
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
                  "Confirm Email",
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
                  formKey: _emailFormKey,
                  icon: const Icon(Icons.email),
                  hintText: 'Email:',
                  onFieldSubmitted: (value) {
                    _confirmEmail();
                  },
                  onEditingComplete: () {
                    _confirmEmail();
                  }),
              const SizedBox(height: 12),
              if (_isLoading)
                const Center(
                    child: CircularProgressIndicator(
                  color: primaryColor,
                ))
              else
                CustomerButton(
                  title: 'Resend Email',
                  onPressed: _confirmEmail,
                ),
              SizedBox(height: 20),
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
