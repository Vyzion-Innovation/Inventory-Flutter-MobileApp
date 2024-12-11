import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Constant/app_colors.dart';
import 'package:inventoryappflutter/Constant/app_logo.dart';
import 'package:inventoryappflutter/Extension/Validator.dart';
import 'package:inventoryappflutter/Login/Controller/login_controller.dart';
import 'package:inventoryappflutter/Extension/constants.dart';
import 'package:inventoryappflutter/common/app_common_button.dart';
import 'package:inventoryappflutter/common/app_text.dart';
import 'package:inventoryappflutter/common/common_sizedbox.dart';
import 'package:inventoryappflutter/common/customTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Obx(() {
        return loginController.isLoading.value ? Center(child: CircularProgressIndicator()):
      Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: loginController.formKey, // Assign the form key
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ClipOval(
                      child: Image.asset(
                        AppLogo.companyLogo,
                        height: MediaQuery.of(context).size.height / 6,
                        fit: BoxFit.scaleDown,
                        matchTextDirection: true,
                      ),
                    ),
                  ),
                  const Center(

                    child:
                    AppText(Strings.welcome, fontSize:20, fontWeight: FontWeight.bold,),
                    
                  ),
                  const CustomSizedBox(height: 30),

                  // Email Field
                  CustomTextField(
                    labelText: Strings.lableEmail,
                    hintText: Strings.hintEmail,
                    controller: loginController.emailController,
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

                  const CustomSizedBox(height: 20),

                  // Password Field
                  Obx(
                    () => CustomTextField(
                      labelText: Strings.lablePassword,
                      hintText: Strings.hintPassword,
                      obscureText: !loginController.passwordVisible.value,
                      controller: loginController.passwordController,
                      suffixVisibility: true,
                      borderSide: const BorderSide(color:AppColors.primaryColor, width: 1.0),
                      suffix: IconButton(
                        icon: Icon(
                          loginController.passwordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.greyColor,
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
                   Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: loginController.rememberMe.value,
                          onChanged: (value) {
                            loginController.toggleRememberMe(value ?? false);
                          
                          },
                        ),
                      ),
                      const Text(Strings.rememberMe),
                    ],
                  ),

                  const CustomSizedBox(height: 20),

                 
                  CustomButton(title: Strings.login, 
                  onTap: () {
                    loginController.login();
                  },),

                   const CustomSizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      );
      }
      )
    );
  }
}
