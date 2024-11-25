import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Login/Controller/login_controller.dart';

class LoginScreenPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: loginController.formKey, // Assign the form key
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Adjust to content size
                    crossAxisAlignment:
                        CrossAxisAlignment.stretch, // Stretch children
                    children: <Widget>[
                      const Center(
                        child: Text(
                          'Welcome',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Email',
                        style: TextStyle(fontSize: 14),
                      ),
                      TextFormField(
                        controller: loginController.usernameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'e.g. abc@gmail.com',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid email';
                          }
                          String pattern =
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                          if (!RegExp(pattern).hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Password',
                        style: TextStyle(fontSize: 14),
                      ),
                      Obx(() => TextFormField(
                            controller: loginController.passwordController,
                            obscureText:
                                !loginController.passwordVisible.value,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Enter password',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  loginController.passwordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                                onPressed: loginController
                                    .togglePasswordVisibility,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          )),
                      const SizedBox(height: 20),
                  
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(212, 72, 70, 197),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: loginController.login,
                          ),
                        ),
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
