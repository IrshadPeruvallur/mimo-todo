import 'package:flutter/material.dart';
import 'package:memo_todo/authentication/controller/auth_controller.dart';
import 'package:memo_todo/authentication/view/login_screen.dart';
import 'package:memo_todo/authentication/view/register_screen.dart';
import 'package:memo_todo/constants/colors.dart';
import 'package:memo_todo/constants/enum.dart';
import 'package:memo_todo/widgets/custom_elevated_button.dart';
import 'package:memo_todo/widgets/custom_snackbar.dart';
import 'package:memo_todo/widgets/custom_text.dart';
import 'package:memo_todo/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                height: size.height * .18,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  CustomText(
                    text: 'Forgot Password',
                    fontWeight: FontWeight.bold,
                    size: 18,
                  ),
                  SizedBox()
                ],
              ),
              SizedBox(
                height: size.height * .02,
              ),
              CustomTextField(
                hint: 'Email',
                controller: authController.emailController,
                type: TextFieldType.email,
              ),
              CustomText(
                text:
                    "Enter the email address you used to create your account, and we will email you a link to reset your password.",
                size: 11,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: size.height * .02,
              ),
              FullWidthElevatedButton(
                  buttonText: "Continue",
                  onPressed: () async {
                    final result = await authController.forgotPassword();
                    if (result != null) {
                      showCustomSnackBar(
                          context: context,
                          type: SnackBarType.error,
                          content: result);
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
