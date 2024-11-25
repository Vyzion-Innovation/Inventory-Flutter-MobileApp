import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Extension/Validator.dart';
import 'package:inventoryappflutter/Login/Controller/login_controller.dart';
import 'package:inventoryappflutter/Extension/constants.dart';
import 'package:inventoryappflutter/common/common_text_button.dart';
import 'package:inventoryappflutter/common/customTextField.dart';

class LoginScreenPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: loginController.formKey, // Assign the form key
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Center(
                    child: Text(
                    Strings.welcome,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Email Field
                  CustomTextField(
                    labelText: Strings.labelEmail,
                    hintText: Strings.labelEmail,
                    controller: loginController.usernameController,
                    input: TextInputType.emailAddress,
                    borderSide: const BorderSide(color:AppColors.primaryColor, width: 1.0),
                    validator: (value) {
                      return Validator.validateFormField(
                        value ?? '',
                        Strings.strErrorEmptyPhone,
                        Strings.strInvalidPhone,
                        Constants.EMAIL_VALIDATION,
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Password Field
                  Obx(
                    () => CustomTextField(
                      labelText: Strings.lablePassword,
                      hintText: Strings.lablePassword,
                      obscureText: !loginController.passwordVisible.value,
                      controller: loginController.passwordController,
                      suffixVisibility: true,
                      borderSide: const BorderSide(color:AppColors.primaryColor, width: 1.0),
                      suffix: IconButton(
                        icon: Icon(
                          loginController.passwordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: loginController.togglePasswordVisibility,
                      ),
                      validator: (value) {
                        return Validator.validateFormField(
                          value ?? '',
                         Strings.passwordRequired,
                         Strings.strInvalidPassword,
                          Constants.PASSWORD_VALIDATION,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Login Button
                  SizedBox(
                    height: 50,
                    child: CustomTextButton(
                    text: Strings.login,
                    onPressed: loginController.login,
                    backgroundColor: AppColors.primaryColor,
                    textColor: Colors.white,
                    fontSize: 16.0,
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
                  ),

                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
