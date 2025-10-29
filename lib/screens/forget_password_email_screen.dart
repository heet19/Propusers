import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:propusers/screens/sign_up_screen.dart';
import 'package:propusers/screens/verify_forget_password_code_screen.dart';
import '../services/remote_service.dart';

class ForgetPasswordEmailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgetPasswordEmailScreenState();
}

class _ForgetPasswordEmailScreenState extends State<ForgetPasswordEmailScreen> {
  final _formKey = GlobalKey<FormState>();

  var EmailController = TextEditingController();

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
        child: LayoutBuilder(
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
                        SizedBox(height: getResponsiveSize(context, 10)),

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

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: getResponsiveSize(context, 50),
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
                                    ),
                                  ),
                                );

                                var service = RemoteService();
                                var response = await service.sendOtp(
                                  email: EmailController.text.trim(),
                                  type: 1,
                                );

                                Navigator.pop(context); // close loader

                                if (response != null &&
                                    response['success'] == true) {
                                  var userOTP = response['data']['otp'];
                                  var userID = response['data']['user'];

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => VerifyForgetPasswordCodeScreen(
                                        user_id: userID.toString(),               // tells the screen it's signup flow
                                        otp: userOTP.toString(),                  // OTP received from API
                                        email: EmailController.text.trim(),
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
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
                              "Send OTP",
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
                              const TextSpan(text: "Don't have an account? "),
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
                                        builder: (context) => SignUpScreen(),
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
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  );
}
