import 'package:fashion_project/auth_service.dart';
import 'package:fashion_project/sign_in_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  String? _selectedCountryCode = '+1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await AuthService().signout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()), // Adjust the route as needed
              );
            },
            child: Container(
              width: 105,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xff704F38),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(85),
              ),
              child: const Center(
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10), // Optional: Adjust spacing between items
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Complete Your Profile ',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Don't worry, only you can see your personal data. No one else will be able to see it.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 80,
                      backgroundColor: Color(0xffE6E6E6),
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.edit,
                            color: Colors.grey,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Name',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name cannot be empty';
                    } else if (value.length < 8) {
                      return 'Name must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Phone Number',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                CustomPhoneNumberField(
                  selectedCountryCode: _selectedCountryCode,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCountryCode = newValue;
                    });
                  },
                ),
                const SizedBox(height: 25),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Gender',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Select',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                  value: _selectedGender,
                  items: ['Male', 'Female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Gender selection is compulsory';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 365,
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color(0xff704F38),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(85),
                    ),
                    child: const Center(
                      child: Text(
                        "Complete Profile",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPhoneNumberField extends StatelessWidget {
  final String? selectedCountryCode;
  final ValueChanged<String?> onChanged;

  const CustomPhoneNumberField({
    Key? key,
    required this.selectedCountryCode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: Row(
        children: [
          const SizedBox(width: 5),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCountryCode,
              items: ['+1', '+91', '+44', '+61', '+81'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: onChanged,
              icon: const Icon(Icons.arrow_drop_down),
            ),
          ),
          const VerticalDivider(
            width: 3,
            color: Colors.black,
          ),
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Phone Number',
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone Number cannot be empty';
                } else if (value.length < 8) {
                  return 'Phone Number must be at least 8 digits';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
