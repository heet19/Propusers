import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:propusers/screens/privacy_policy_screen.dart';
import 'package:propusers/screens/terms_and_conditions_screen.dart';
import 'package:propusers/screens/verify_code_screen.dart';
import '../services/remote_service.dart';

enum UserType { buyer, seller }

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  UserType selectedType = UserType.buyer;
  var FullNameController = TextEditingController();
  var PhoneController = TextEditingController();
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  var ConfirmPasswordController = TextEditingController();

  String? selectedCity;
  List<String> cityList = [];

  bool _obscureTextPassword = true;
  bool _obscureTextConformPassword = true;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    fetchCities();
  }

  Future<void> fetchCities() async {
    var service = RemoteService();
    var response = await service.getProprenuerDropdown();
    if (response != null && response.data != null) {
      List<String> fetchedCities = response.data.cities?.map((e) => e.cityName).toList() ?? [];
      setState(() {
        cityList = fetchedCities;
      });
    }
  }

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

                // Buyer / Seller Selection
                BuyerSellerBtn(
                  selectedType: selectedType,
                  onChanged: (type) {
                    setState(() { selectedType = type;});
                  },
                ),
                const SizedBox(height: 20),

                // Full Name
                CustomField(
                  controller: FullNameController,
                  hintText: "Full Name",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty)
                      return 'Name is required';
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Phone
                CustomField(
                  controller: PhoneController,
                  hintText: "Phone Number",
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty)
                      return 'Phone No is required';
                    if (!RegExp(r'^\d+$').hasMatch(value.trim()))
                      return 'Only digits allowed';
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Email
                CustomField(
                  controller: EmailController,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty)
                      return 'Email is required';
                    if (!isValidEmail(value.trim()))
                      return 'Invalid email address';
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // City Dropdown
                DropdownButtonFormField<String>(
                  decoration: fieldDecoration("Select City"),
                  dropdownColor: Colors.white,
                  icon: const Icon(Icons.arrow_drop_down),
                  value: selectedCity,
                  validator: (value) =>
                  value == null ? 'Please select a city' : null,
                  onChanged: (value) => setState(() => selectedCity = value),
                  items: cityList.map((city) {
                    return DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),

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

                // Checkbox
                CheckboxListTile(
                  activeColor: const Color(0xFFF5C954),
                  value: isChecked,
                  onChanged: (value) { setState(() => isChecked = value ?? false); },
                  controlAffinity: ListTileControlAffinity.leading,
                  title: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        const TextSpan(text: "By signing up you agree to our "),
                        TextSpan(
                          text: "Terms and Conditions",
                          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionsScreen(),));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Terms and Conditions"),),
                              );
                            },
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyScreen(),));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Privacy Policy"),),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

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
                        if (!isChecked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please accept Terms & Privacy"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFF5C954),
                              )),
                        );

                        var service = RemoteService();
                        var response = await service.signUp(
                          name: FullNameController.text.trim(),
                          email: EmailController.text.trim(),
                          password: PasswordController.text.trim(),
                          contact: PhoneController.text.trim(),
                          city: selectedCity ?? '',
                          type: selectedType == UserType.buyer
                              ? 'Buyer'
                              : 'Seller',
                        );

                        Navigator.pop(context); // close loader

                        if (response != null && response['success'] == true) {
                          final otp = response['otp'];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VerifyCodeScreen(
                                name: FullNameController.text.trim(),
                                email: EmailController.text.trim(),
                                password: PasswordController.text.trim(),
                                contact: PhoneController.text.trim(),
                                city: selectedCity ?? '',
                                type: selectedType == UserType.buyer
                                    ? 'Buyer'
                                    : 'Seller',
                                otp: otp.toString(),
                              ),
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
                      "SUBMIT",
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
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
  );
}

// Buyer / Seller Button
class BuyerSellerBtn extends StatelessWidget {
  final UserType selectedType;
  final ValueChanged<UserType> onChanged;

  const BuyerSellerBtn({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<UserType>(
      segments: <ButtonSegment<UserType>>[
        ButtonSegment<UserType>(
          value: UserType.buyer,
          label: Text(
            'Buyer',
            style: TextStyle(
              color: selectedType == UserType.buyer
                  ? Colors.black
                  : Colors.grey[700],
            ),
          ),
        ),
        ButtonSegment<UserType>(
          value: UserType.seller,
          label: Text(
            'Seller',
            style: TextStyle(
              color: selectedType == UserType.seller
                  ? Colors.black
                  : Colors.grey[700],
            ),
          ),
        ),
      ],
      selected: <UserType>{selectedType},
      onSelectionChanged: (Set<UserType> newSelection) {
        onChanged(newSelection.first);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => Colors.yellow.shade100,
        ),
      ),
    );
  }
}
