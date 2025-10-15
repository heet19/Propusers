import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propusers/screens/propusers_screen.dart';
import 'package:propusers/theme/theme.dart';

import '../services/remote_service.dart';
import 'home_screen.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String contact;
  final String city;
  final String type;
  final String otp;

  const VerifyCodeScreen({
    super.key,
    required this.name,
    required this.password,
    required this.contact,
    required this.city,
    required this.type,
    required this.email,
    required this.otp
  });

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final List<TextEditingController> _otpControllers =
  List.generate(6, (index) => TextEditingController());
  int _secondsRemaining = 90;
  late Timer _timer;
  bool _isResendVisible = false;
  late String _currentOtp;

  @override
  void initState() {
    super.initState();
    _currentOtp = widget.otp; // initialize with the OTP from previous screen
    startTimer();
  }

  void startTimer() {
    _secondsRemaining = 90;
    _isResendVisible = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _isResendVisible = true;
        });
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      FocusScope.of(context).nextFocus();
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus();
    }
  }

  void _submitOtp() {
    String enteredOtp = _otpControllers.map((c) => c.text).join().trim();

    if (enteredOtp.isEmpty || enteredOtp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the complete 6-digit OTP')),
      );
      return;
    }

    if (enteredOtp == widget.otp || enteredOtp == _currentOtp) {
      //  OTP matches — navigate to HomeScreen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP Verified Successfully!')),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(
          name: widget.name,
          email: widget.email,
          password: widget.password,
          contact: widget.contact,
          city: widget.city,
          type: widget.type,
        )),
            (route) => false,
      );
    } else {
      //  OTP mismatch
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP, please try again')),
      );
    }
  }

  void _resendOtp() async {
    setState(() {
      _isResendVisible = false;
      _secondsRemaining = 90;
    });

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    var service = RemoteService();
    var response = await service.resendOtp(email: widget.email, type: "1"); // type=1 for signup

    Navigator.pop(context); // close loading

    if (response != null && response['success'] == true) {
      setState(() {
        _currentOtp = response['otp'].toString(); // update OTP locally
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP resent successfully')),
      );
      startTimer();
    }
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Logo Section
                Image.asset(
                  'assets/images/logo.png', // your logo
                  height: 70,
                ),

                // Image + Circle + Now badge
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow.withOpacity(0.15),
                      ),
                    ),
                    ClipOval(
                      child: Image.asset(
                        'assets/images/squarelogo.png', // replace with your image
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 60,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "NOW",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),

                // Verify Texts
                Column(
                  children: [
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Verify ",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "Code",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "An Authentication code has been sent to",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //  User Email Text
                        Text(
                          widget.email,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.visible,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              overflow: TextOverflow.visible,
                              fontSize: 16
                          ),
                        ),
                        const SizedBox(width: 10),
                        //  Edit Icon
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primary, // light background tint
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                        ),
                        ),

                      ],
                    )
                  ],
                ),

                // OTP Fields + Timer + Resend
                Column(
                  children: [

                    //  Enter OTP Text
                    Text(
                      'Enter 6 Digit OTP',
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          overflow: TextOverflow.visible,
                          fontSize: 12
                      ),
                    ),

                    SizedBox(height: 10),

                    // OTP Fields
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (index) {
                          return Container(
                            width: 45,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: TextField(
                              controller: _otpControllers[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              onChanged: (value) => _onOtpChanged(value, index),
                              decoration: InputDecoration(
                                counterText: "",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 8), //  Reduced space here (was large before)

                    // Timer + Resend (left-right aligned)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _isResendVisible
                                ? "OTP Expired"
                                : "Valid upto $_secondsRemaining sec",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: _isResendVisible ? _resendOtp : null,
                            child: Text(
                              "Resend OTP",
                              style: TextStyle(
                                color: _isResendVisible
                                    ? Colors.orange
                                    : Colors.grey.shade400,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Submit Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                      ),
                      onPressed: _submitOtp,
                      child: const Text(
                        "Verify",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
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
