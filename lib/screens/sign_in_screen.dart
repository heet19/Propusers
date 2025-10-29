import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:propusers/models/sign_in_models/sign_in_model.dart';
import 'package:propusers/screens/forget_password_email_screen.dart';
import 'package:propusers/screens/home_screen.dart';
import 'package:propusers/screens/sign_up_screen.dart';
import 'package:propusers/theme/theme.dart';
import '../services/remote_service.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();

  bool _obscureTextPassword = true;

  bool isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    return RegExp(pattern).hasMatch(email);
  }

  // Move this method outside build
  double getResponsiveSize(BuildContext context, double size) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    return isTablet ? size * 1.3 : size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: getResponsiveSize(context, 25),
                    vertical: getResponsiveSize(context, 20),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // LOGO
                            Image.asset(
                              'assets/images/logo.png',
                              height: getResponsiveSize(context, 80),
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: getResponsiveSize(context, 20)),

                            // TITLE
                            titleText(context),

                            // Email + Password Fields
                            textFields(context),

                            // Submit Button
                            SizedBox(
                              width: double.infinity,
                              height: getResponsiveSize(context, 50),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF5C954),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_) => const Center(
                                        child: CircularProgressIndicator(
                                          color: Color(0xFFF5C954),
                                        ),
                                      ),
                                    );

                                    var service = RemoteService();
                                    var response = await service.signIn(
                                      email: EmailController.text.trim(),
                                      password: PasswordController.text.trim(),
                                      type: 1,
                                      userType: 'Buyer',
                                    );

                                    Navigator.pop(context); // close loader

                                    if (response != null &&
                                        response['success'] == true) {
                                      SignInModel user = response['user'];

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => HomeScreen(
                                            email: user.email,
                                            password: PasswordController.text
                                                .trim(),
                                            name: user.name,
                                            contact: user.contact,
                                            city: '',
                                            type: user.userType,
                                          ),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            response?['message'] ??
                                                response?['error'] ??
                                                'Something went wrong',
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  "SIGN IN",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: getResponsiveSize(context, 16),
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: getResponsiveSize(context, 20)),

                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getResponsiveSize(context, 14),
                                ),
                                children: [
                                  const TextSpan(
                                    text: "Don't have an account? ",
                                  ),
                                  TextSpan(
                                    text: "Sign up",
                                    style: const TextStyle(
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen(),
                                          ),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 16,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomeScreen(
                        email: '',
                        password: '',
                        name: '',
                        contact: '',
                        city: '',
                        type: 'Guest',
                      ),
                    ),
                  );
                },
                child: Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleText(BuildContext context) {
    return Column(
      children: [
        Text(
          "Sign In",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: getResponsiveSize(context, 24),
          ),
        ),
        SizedBox(height: getResponsiveSize(context, 4)),
        Text(
          "Please enter the details below to continue.",
          style: TextStyle(
            color: Colors.black54,
            fontSize: getResponsiveSize(context, 14),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget textFields(BuildContext context) {
    return Column(
      children: [
        // Email
        CustomField(
          controller: EmailController,
          hintText: "Email",
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Email is required';
            }
            if (!isValidEmail(value.trim())) {
              return 'Invalid email address';
            }
            return null;
          },
        ),
        SizedBox(height: getResponsiveSize(context, 10)),

        // Password
        CustomField(
          controller: PasswordController,
          hintText: "Password",
          obscureText: _obscureTextPassword,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureTextPassword ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() => _obscureTextPassword = !_obscureTextPassword);
            },
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
            return null;
          },
        ),
        SizedBox(height: getResponsiveSize(context, 20)),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 1),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getResponsiveSize(context, 14),
                ),
                children: [
                  TextSpan(
                    text: "Forget Password?",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPasswordEmailScreen(),
                          ),
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
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
