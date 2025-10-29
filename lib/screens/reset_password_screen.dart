import 'package:flutter/material.dart';
import 'package:propusers/screens/sign_in_screen.dart';
import '../services/remote_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String
  user;

  const ResetPasswordScreen({super.key, required this.user});


  @override
  State<StatefulWidget> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  var PasswordController = TextEditingController();
  var ConfirmPasswordController = TextEditingController();

  bool _obscureTextPassword = true;
  bool _obscureTextConformPassword = true;
  bool isChecked = false;

  bool isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    return RegExp(pattern).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // LOGO
                Image.asset(
                  'assets/images/logo.png',
                  height: 80,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),

                // IMAGE SECTION
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     ClipOval(
                //       child: Image.asset(
                //         'assets/images/squarelogo.png', // change to your image
                //         height: 100,
                //         width: 100,
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 25),

                // TITLE
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Registered with your valid Email",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 25),


                // Password
                CustomField(
                  controller: PasswordController,
                  hintText: "Password",
                  obscureText: _obscureTextPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureTextPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _obscureTextPassword = !_obscureTextPassword);
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Password is required';
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Confirm Password
                CustomField(
                  controller: ConfirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: _obscureTextConformPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureTextConformPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _obscureTextConformPassword = !_obscureTextConformPassword);
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Confirm password required';
                    if (value != PasswordController.text)
                      return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5C954),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFF5C954),
                              )),
                        );

                        var service = RemoteService();
                        var response = await service.resetPassword(
                          userId: widget.user,
                          password: PasswordController.text.trim(),
                          confirmPassword: ConfirmPasswordController.text.trim(),
                        );

                        Navigator.pop(context); // close loader

                        if (response != null && response['success'] == true) {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SignInScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  response?['error'] ?? 'Something went wrong'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Change Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Field Widget
class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CustomField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: fieldDecoration(hintText).copyWith(suffixIcon: suffixIcon),
    );
  }
}

// Common decoration
InputDecoration fieldDecoration(String label) {
  return InputDecoration(
    hintText: label,
    filled: true,
    fillColor: const Color(0xFFF4F4F4),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  );
}