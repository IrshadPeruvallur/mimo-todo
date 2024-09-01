import 'package:flutter/material.dart';
import 'package:memo_todo/authentication/controller/auth_controller.dart';
import 'package:memo_todo/authentication/view/forgot_password.dart';
import 'package:memo_todo/authentication/view/register_screen.dart';
import 'package:memo_todo/constants/colors.dart';
import 'package:memo_todo/constants/enum.dart';
import 'package:memo_todo/features/home/home_screen.dart';
import 'package:memo_todo/widgets/custom_elevated_button.dart';
import 'package:memo_todo/widgets/custom_snackbar.dart';
import 'package:memo_todo/widgets/custom_text.dart';
import 'package:memo_todo/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authController = Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * .1,
              ),
              Center(
                child: Image.asset(
                  'assets/logo/memo_logo.png',
                  width: size.width * 0.4,
                ),
              ),
              SizedBox(
                height: size.height * .1,
              ),
              CustomTextField(
                controller: authController.emailController,
                hint: 'Email',
                type: TextFieldType.email,
              ),
              CustomTextField(
                controller: authController.passwordController,
                type: TextFieldType.email,
                hint: 'Password',
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    )),
                child: CustomText(
                  text: 'Forgot Password?',
                  size: 11,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              FullWidthElevatedButton(
                  buttonText: "Continue",
                  onPressed: () async {
                    final result = await authController.loginUser();
                    if (result != null) {
                      showCustomSnackBar(
                          context: context,
                          type: SnackBarType.error,
                          content: result);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    }
                  }),
              SizedBox(
                height: size.height * 0.05,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Don't have an account? ",
                      size: 11,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          )),
                      child: CustomText(
                        text: "Register",
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700,
                        size: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
