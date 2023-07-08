import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/src/business_layer/network/request_response_type.dart';
import 'package:to_do_app/src/business_layer/providers/auth_provider.dart';
import 'package:to_do_app/src/business_layer/util/helper/validator.dart';
import 'package:to_do_app/src/data_layer/res/app_colors.dart';
import 'package:to_do_app/src/data_layer/res/numbers.dart';
import 'package:to_do_app/src/ui_layer/screens/home/home_dashboard/home_widget.dart';
import 'package:to_do_app/src/ui_layer/screens/onboarding/signup_screen.dart';
import 'package:to_do_app/src/ui_layer/widgets/app_buttons.dart';
import 'package:to_do_app/src/ui_layer/widgets/app_text_fields.dart';
import 'package:to_do_app/src/ui_layer/widgets/toast_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  late AuthProvider _authProvider;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _pwdFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _authProvider = Provider.of<AuthProvider>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.mainColor,
      body: Provider.of<AuthProvider>(context, listen: true).loading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            ))
          : _loginWidget(),
    );
  }

  /// returns whole login widget
  _loginWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 58.0),
          child: Center(
            child: Text(
              "ToDo App",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppColors.whiteColor, fontStyle: FontStyle.italic),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: Colors.white,
          ),
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Sign In",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        emailTextField(),
                        const SizedBox(height: 15.0),
                        passwordTextField(),
                        const SizedBox(
                          height: 20,
                        ),
                        dontHaveAccount(),
                        const Spacer(),
                        _submitButton(),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

// email field
  Widget emailTextField() {
    return CustomTextField(
        focusNode: _emailFocus,
        showBorders: true,
        radius: 8,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        hintText: "Email Address",
        contentPadding: const EdgeInsets.symmetric(vertical: d_18),
        validator: (val) => Validator.checkLoginEmailErrorMessage(val!));
  }

// password field
  Widget passwordTextField() {
    return CustomTextField(
        focusNode: _pwdFocus,
        onChanged: (val) {},
        showBorders: true,
        radius: 8,
        controller: _passwordController,
        keyboardType: TextInputType.text,
        hintText: "Password",
        contentPadding: const EdgeInsets.symmetric(vertical: d_18),
        inputFormatters: [LengthLimitingTextInputFormatter(i_15)],
        validator: (val) => Validator.checkLoginPasswordErrorMessage(val!));
  }

  // signup segment
  Widget dontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don’t have an account?",
          style: TextStyle(
              fontSize: d_13,
              color: neutral2color,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal),
        ),
        const SizedBox(
          width: d_9,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            "Sign up now!",
            style: TextStyle(
                fontSize: d_13,
                fontWeight: FontWeight.w500,
                color: backgroundColor,
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.normal),
          ),
        )
      ],
    );
  }

// submit button
  _submitButton() {
    return CommonButton(
      label: "SIGN IN",
      onTap: _handleLoginTap,
      active: true,
    );
  }

// handle sign in
  Future<void> _handleLoginTap() async {
    if (_formKey.currentState!.validate()) {
      _authProvider.loading = true;
      String res = await _authProvider.loginUser(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      _authProvider.loading = false;

      if (res == ResponseTypes.success) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        // ignore: use_build_context_synchronously
        MessageHelper.showSnackBar(context, res);
      }
    }
  }
}
