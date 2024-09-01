import 'package:flutter/material.dart';
import 'package:memo_todo/authentication/controller/auth_controller.dart';
import 'package:memo_todo/authentication/view/login_screen.dart';
import 'package:memo_todo/constants/colors.dart';
import 'package:memo_todo/constants/enum.dart';
import 'package:memo_todo/widgets/custom_elevated_button.dart';
import 'package:memo_todo/widgets/custom_snackbar.dart';
import 'package:memo_todo/widgets/custom_text.dart';
import 'package:memo_todo/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                    text: 'Create an Account',
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
                hint: 'Full Name',
                type: TextFieldType.name,
              ),
              CustomTextField(
                controller: authController.emailController,
                hint: 'Email',
                type: TextFieldType.email,
              ),
              CustomTextField(
                controller: authController.passwordController,
                type: TextFieldType.password,
                hint: 'Password',
              ),
              CustomTextField(
                type: TextFieldType.confirmPassword,
                hint: 'Confirm Password',
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              FullWidthElevatedButton(
                  buttonText: "Continue",
                  onPressed: () async {
                    final result = await authController.registerUser();
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
                      text: "Already have an account? ",
                      size: 11,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: CustomText(
                        text: "Log In ",
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
